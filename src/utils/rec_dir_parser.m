% Creates a struct that stores the directory tree.

function files = rec_dir_parser(dir_name)
files = dir(dir_name);
for i=1:length(files)
    files(i).rel_path = dir_name;
    if ~strcmp('.',files(i).name) && ...
       ~strcmp('..',files(i).name)
        if files(i).isdir
            files(i).files = ...
                rec_dir_parser([dir_name filesep files(i).name filesep]);
        end
    end
end