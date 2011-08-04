function whiteboard( db )
if nargin < 1
    db = [];
end

recog = ~(nargin < 1);  % bool variable ( nargin < 1 ==> recog = false )

f = figure;

t = trace;

pt = [0 0];
last_pt = [0 0];

aH = axes('Xlim', [0 1], 'Ylim', [0 1]);

% h = line([0.5 0.5], [0 1], ...
%     'color', 'red', ...
%     'linewidth', 3, ...
%     'ButtonDownFcn', @startDragFcn);

set(f,'WindowButtonUpFcn', @stopDragFcn);
set(aH,'ButtonDownFcn', @startDragFcn);

% startDragFcn
    function startDragFcn(varargin)
        hold all
        pt = getPosition()
        disp('startDragFcn');
        t.channel{1} = pt(1);
        t.channel{2} = pt(2);
        set(f,'WindowButtonMotionFcn', @draggingFcn)
    end

% draggingFcn
    function draggingFcn(varargin)
        last_pt = pt;
        pt = getPosition()
        x = [pt(1) last_pt(1)];
        y = [pt(2) last_pt(2)];
        
        t.channel{1} = [t.channel{1} pt(1)];
        t.channel{2} = [t.channel{2} pt(2)];
        
        plot( x, y, 'o', ...
            'LineWidth', 1,  ...
            'MarkerEdgeColor','b', ...
            'MarkerFaceColor','g', ...
            'MarkerSize', 4);
        
%         line( x, y, ...
%              'color', 'black', ...
%              'linewidth', 1)
%         
%         plot( pt(1), pt(2), 'o', ...
%             'MarkerFaceColor','g', ...
%             'MarkerSize', 2);
        
        
%         disp('draggingFcn');
    end

% stopDragFcn
    function stopDragFcn(varargin)
%         hold off;
        set(f,'WindowButtonMotionFcn', '')
        disp('stopDragFcn');
        
        %% recognition
        if recog
            t.normalize();
            class = recognition(t, db, 12, MethodRecog.cityblock);
            label = db.idx2label( class )
        end
    end

    function point = getPosition()
        point = get(aH, 'CurrentPoint');
        point = point(1,1:2);  % extract x and y
    end
end