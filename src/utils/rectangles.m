% Creates multiple rectangles one at a time.
%
% Input p is nx4 with every row corrsponding to
% the [x y w h color] of a rectangle as defined in
% the rectangle matlab function.

% version 0.82

% e.g. rectangles2(files(i).pd, params)

function rectangles(p, colors, uFaceIDs, contactMap)


if ~exist('contactMap', 'var')
    contactMap = [];
end

for i = 1:size(p.dets,1)

    
   h = rectangle('Position', p.dets(i,1:4));
   fID = faceID2Index(uFaceIDs, p.faceIDs{i});
   if isempty(contactMap)
       text(p.dets(i,1)+5, p.dets(i,2) - 70, num2str(fID-1), 'color', colors(fID,:), 'fontsize', 15);
   else 
       text(p.dets(i,1)+5, p.dets(i,2) - 70, contactMap(p.faceIDs{i}), 'color', colors(fID,:), 'fontsize', 15);
   end
   set(h,'Curvature', [0 0], 'LineWidth', 3, 'EdgeColor', colors(fID,:));


end
    
