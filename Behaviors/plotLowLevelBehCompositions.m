%********************* Documentation **************************************
% This function LABELS the plot of primitives with composition labels. 
% The set of compositions include: (alignment, increase, decrease, constant)
% and represendted by the strings: ('a','i','d','c').
% 
% Positioning of Labels:
% The dependent axis is time. The average time between two primitives that
% have been compounded together is used to set the x-position of the label.
%
% The y-position is set 
% 
% Text Labeling:
% The text labeling is performed by extracting the first category or
% element of the CELL ARRAY motComps of type string. 
%
% data:     - refers to the llbehStruc[llBehClass,avgVal,rmsVal,AmplitudeVal,mc1,mc2,t1Start,t1End,t2Start,t2End,tavgIndex]
%
% Output Parameters:
% htext         - handle to the text objects in case user wants to modify
%**************************************************************************
function htext = plotLowLevelBehCompositions(StrategyType,rHandle,TL,BL,data)

%%  Preprocessing
    len     = length(rHandle);          % Check how many hanlde entries we have
    r       = size(data);               % Get the # entries of motion compositions
    htext   = zeros(r(1),1);               % This is a text handle and can be used if we want to modify/delete the text

    % Indeces
    LblIndex  = 1;                % type of composition: alignment, increase, decrease, constant
    AvgTime   = 17;                % Used as an index
    
   % Maximum height of plot
    fig_handle = gca;
    maxHeight = fig_handle.YLim(2);
    minHeight = fig_handle.YLim(1);
    
    % Set Text Height Limit
    if(TL>maxHeight)
        TL=maxHeight;
    elseif(TL<minHeight)
        TL=minHeight;
    end
    
    % Set Scaling Factor for Labels
    % PA10
    if(~strcmp(StrategyType,'SIM_SideApproach') && ~strcmp(StrategyType(1:12),'SIM_SA_Error') && ~strcmp(StrategyType,'SIM_SA_DualArm'))        
        if(TL>0) % Positive plot
            k=0.75;                   
        else % Negative Plot
            k=1.25;
        end
    % HIRO plots
    else
        if(TL>0) % Positive plot
            k=0.75;                   
        else % Negative Plot
            k=1.25;
        end
    end    
    
%%  Labeling
    
    % For each of the handles
    for i=1:len                                 % getting 7 handles instead of six...
        
        % For each of the compositions
        for index=1:r(1);                                    % rows
            if(~strcmp(StrategyType,'SIM_SideApproach') && ~strcmp(StrategyType(1:12),'SIM_SA_Error') &&  ~strcmp(StrategyType,'SIM_SA_DualArm'))
                htext(i)=text(data(index,AvgTime),...               % x-position. Average time of composition.
                             (k*TL(i)+(0.10*randn*TL(i))),...   % y-position. No randomness here since there is no overcrowding... //Set it at 75% of the top boundary of the axis +/- randn w/ sigma = TL*0.04
                              data(index,LblIndex),...              % Composition string: alignment, increase, decrease, constant.
                              'Color',[1,0,0],...                   % Font color
                              'FontSize',8.5,...                  	% Size of font. Changed from 7.5 to 8.5
                              'FontWeight','light',...              % Font weight can be light, normal, demi, bold
                              'HorizontalAlignment','center');      % Alignment of font: left, center, right. 
            % HIRO Side Approach and related. No variability
            else
                htext(i)=text   (data(index,AvgTime),...                  % x-position. Average time of composition.
                                (k*TL(i)),...                          % y-position. No randomness here since there is no overcrowding... //Set it at 75% of the top boundary of the axis +/- randn w/ sigma = TL*0.04
                                 llbInt2llbLbl(...
                                    data(index,LblIndex)),...             % Composition string: alignment, increase, decrease, constant.
                                'Color',              [1,0,0],...         % Font color
                                'FontSize',            8.5,...            % Size of font. Changed from 7.5 to 8.5
                                'FontWeight',         'light',...         % Font weight can be light, normal, demi, bold
                                'HorizontalAlignment','center');          % Alignment of font: left, center, right. 
            end
        end
    end       
end