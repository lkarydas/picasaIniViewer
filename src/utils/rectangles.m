% Creates multiple rectangles one at a time.
%
% Input p is nx4 with every row corrsponding to
% the [x y w h color] of a rectangle as defined in
% the rectangle matlab function.

% version 0.82

% e.g. rectangles2(files(i).pd, params)

function rectangles(p, colors, uFaceIDs, finalizedIDs)

if ~exist('finalizedIDs', 'var')
    finalizedIDs = [];
end

for i = 1:size(p.dets,1)

    
    
    
    fID = faceID2Index(uFaceIDs, p.faceIDs{i});
    finalized = false;
    if ~isempty(finalizedIDs)
        for j = 1:length(finalizedIDs)
            if strcmp(finalizedIDs{j}, p.faceIDs{i})
                finalized = true;
                break;
            end
        end
        
    end
    if finalized
        continue;
    end
    
    h = rectangle('Position', p.dets(i,1:4));
    text(p.dets(i,1)+5, p.dets(i,2) + 15, num2str(fID-1), 'color', colors(fID,:), 'fontsize', 20);
    set(h,'Curvature', [0 0], 'LineWidth', 3, 'EdgeColor', colors(fID,:));


end
    
