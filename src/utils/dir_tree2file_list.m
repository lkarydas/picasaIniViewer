function file_list = dir_tree2file_list(file_struct, file_list)
for i = 1:length(file_struct)
    if ~strcmp('.',file_struct(i).name) && ... 
       ~strcmp('..',file_struct(i).name)
        [dum,dum,extension] = fileparts(file_struct(i).name); %#ok<ASGLU>
        clear dum;
        if strcmpi(extension,'.jpg') || strcmpi(extension,'.png')
            tmp.name = file_struct(i).name; 
            tmp.rel_path = file_struct(i).rel_path;
            tmp.abs_path = [pwd filesep file_struct(i).rel_path];
            tmp.datenum = file_struct(i).datenum;
            %display(tmp.name)
            % Read metadata information
            tmp.info = imfinfo([tmp.abs_path filesep tmp.name]);
            file_list = [file_list tmp]; %#ok<AGROW>
        end
        if file_struct(i).isdir
            file_list = ...
                dir_tree2file_list(file_struct(i).files, file_list);
        end
    end
end