% Picasa INI Viewer
%
% Use left and right arrows to go to previous/next image.
% When you are done, press 'q' to close the figure.

function picasaIniViewer()
clear,clc,close('all')

param.picturesDir = '../test_pictures';

% Add paths
addpath('utils');

global files;
global contactMap;
% Get a list of all jpg files
% TODO: If third arg is true, you have to catch the exception when
% loading corrupt JPG files.
files = get_file_list(param.picturesDir, '.jpg', true);
% Parse .picasa.ini
code = 1;   % Code to use for initial picasa detections
[files contactMap] = parse_picasa_version_3(files, param, code);

counter = 0;
for f = 1:length(files)
    for j = 1:length(files(f).picasa1.faceIDs)
        counter = counter + 1;
        faceIDs{counter} = files(f).picasa1.faceIDs{j}; %#ok<AGROW>
    end
    
end
global uFaceIDs;
uFaceIDs = unique(faceIDs);
nofPeople = length(uFaceIDs);
global colors;
colors = distinguishable_colors(nofPeople);

global i;
i = 1;
h_fig = 1;

%outputFrameNumbers(files, uFaceIDs, 'frameNumberPerPerson.txt');
%makeFullscreenWindow(h_fig);
redraw();
printInfo()
set(h_fig,'KeyPressFcn',@(h_obj,evt) MyKeyPress(evt.Key, h_fig));
end

function redraw()
    global i;
    global files;
    global colors;
    global uFaceIDs;
    global contactMap;
    I = imread([files(i).rel_path filesep files(i).name]);
    imshow(I, 'InitialMagnification', 'fit')
    w = files(i).info.Width;
    h = files(i).info.Height;
    title([num2str(i) '. ' files(i).name '  size: ' num2str(w) 'x' num2str(h)], 'Interpreter', 'None')
    rectangles(files(i).picasa1, colors, uFaceIDs, contactMap);
    printInfo()
end

function MyKeyPress(key, h_fig)
    global i;
    global files;
    
    if strcmp(key,'rightarrow')
        if i < length(files)
            i = i + 1;
            redraw()
        end
    end
    
    if strcmp(key,'leftarrow')
        if i > 1
            i = i - 1;
            redraw()
        end
    end   
    if strcmp(key,'q')
        clc
        close(h_fig)
    end
end

function printInfo()
global uFaceIDs;
%clc
for i = 1:length(uFaceIDs)
    disp([sprintf('%02i',i-1) ': ' uFaceIDs{i}]);
end
fprintf('\n');

fprintf('Use the left/right arrow keys to go to prev/next image...\n')
fprintf(['Total number of people found: ' num2str(length(uFaceIDs)) '\n\n']);
end