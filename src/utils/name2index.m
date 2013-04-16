

function i = name2index(files, filename)
for i = 1:length(files)  
    if strcmpi(files(i).name, filename)
        return
    end
end
disp(['name2index.m: The name ' filename ' was not found!'])
i = -1;