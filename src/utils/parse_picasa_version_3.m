function [files contactMap] = parse_picasa_version_3(files, param, code)

fprintf(['Importing face detections from ' ...
    param.picturesDir filesep '.picasa.ini ... '])

fid = fopen([param.picturesDir filesep '.picasa.ini']);

if fid<0
    error(['parse_picasa_version_3: Check that you have the .picasa.ini '... 
        'file in the folder ./' param.picturesDir]);
end

% Initialize picasa1 fields
for i = 1:length(files)
    files(i).picasa1.dets = [];
    files(i).picasa1.faceIDs = [];
end

counter = 0;
skipNextLine = false;
contactMap = containers.Map();
tline = fgetl(fid);
while ischar(tline)
    
    if tline(1) == '['
        
        if strcmpi(tline, '[Picasa]')
            % This is the [Picasa] tag which holds folder information
            % ignore
        elseif strcmpi(tline, '[Contacts2]')
            % Parse the contact map (HashID -> Contact name)
            tline = fgetl(fid);
            while ischar(tline) && tline(1) ~= '['
                disp(['Processing: ' tline])
                eqInd = strfind(tline, '=');
                hashID = tline(1:eqInd-1);
                name = tline(eqInd+1:end-2);
                % Parser debugging
                % disp(['Hash: ' hashID]);
                % disp(['Name: ' name]);
                contactMap(hashID) = name;
                tline = fgetl(fid);
            end
            skipNextLine = true;    
                
        else
            file_name = tline(2:end-1);
            tline = fgetl(fid);
            % Find a line starting with 'faces='
            while ischar(tline) && ...
                    ~strcmpi(tline(1:6),'faces=') && tline(1) ~= '['
                    
                tline = fgetl(fid);
            end
            if length(tline) > 6
                if strcmpi(tline(1:6),'faces=')
                    index = name2index(files,file_name);
                    if index > 0
                        img_w = files(index).info.Width;
                        img_h = files(index).info.Height;
                        % Extract the detections from the line of text
                        [dets faceIDs] = decode_face_line(tline, [img_w img_h]);
                        counter = counter+1;
                        %disp(num2str(counter))
                        % These detections are 1x4 each, there is not code tag
                        dets = [dets repmat(code, size(dets,1), 1)]; %#ok<AGROW>
                        files(index).picasa1.dets = [files(index).picasa1.dets; dets];
                        files(index).picasa1.faceIDs = [files(index).picasa1.faceIDs faceIDs];
                    else
                        disp(['Warning: File ' file_name ' appears in picasa.ini but not in the files struct.']);
                    end
                end
            end
        end
    end
    if skipNextLine
        skipNextLine = false;
    else
        tline = fgetl(fid);
    end
end

disp('Done.')