function files = get_file_list(dataset_dir, ext, readEXIF, verbose)

if ~exist('verbose', 'var')
    verbose = true;
end

if ~exist('readEXIF', 'var')
    readEXIF = true;
end

if ~exist('ext', 'var')
    ext = '.jpg';
end

if verbose
    fprintf('Getting list of files...')
end
% Parse all directories recursively
file_struct = rec_dir_parser(dataset_dir);
% Convert the directory tree to a file list
files = dir_tree2file_list(file_struct, [], ext, readEXIF);
if verbose
    disp('Done.')
    disp(['Total files: ' num2str(length(files))])
end