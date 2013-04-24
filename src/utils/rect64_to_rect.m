function rect = rect64_to_rect(hex_pos, img_size)
% rect64_to_rect
% Decodes a Picasa encoded hash string to a [x y w h] rectangle.

while length(hex_pos) < 16
    hex_pos = ['0' hex_pos]; %#ok<AGROW>
end

% Hex to decimal
f1 = hex2dec(hex_pos(1:4));
f2 = hex2dec(hex_pos(5:8));
f3 = hex2dec(hex_pos(9:12));
f4 = hex2dec(hex_pos(13:16));
% Get image size
w = img_size(1);
h = img_size(2);
% Multiply coordinates by image dimensions
face_pos = [w*f1 h*f2 w*f3 h*f4];
face_pos = face_pos/65535;
w = face_pos(3) - face_pos(1);
h = face_pos(4) - face_pos(2);

if h < 0 
    h = img_size(2) - face_pos(2);
end
rect = [face_pos(1) face_pos(2) w h];