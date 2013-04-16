function [dets faceIDs] = decode_face_line(tline, img_size)
counter = 0;
dets = [];
faceIDs = [];
tline = tline(7:end);
keep_going = 1;
while(keep_going)
    i = findstr(tline,';');
    if isempty(i)
        temp = tline;
        keep_going = 0;
    else
        temp = tline(1:i-1);
        tline = tline(i+1:end);
    end
    i = findstr(temp, ')');
    face_pos = temp(8:i-1);
    face_id = temp(i+2:end);
	
	if strcmp(face_id, 'ffffffffffffffff')
		continue;
	end
	
    if ~isempty(face_pos)
        dets(end+1,:) = ...
            rect64_to_rect(face_pos, img_size); %#ok<AGROW>
    end
    if ~isempty(face_id)
        counter = counter + 1;
        faceIDs{counter} = face_id;
    end
end