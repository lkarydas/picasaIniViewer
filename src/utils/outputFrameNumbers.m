function outputFrameNumbers(files, uFaceIDs, outFile)


fid = fopen(outFile, 'w');

personCounter = 0;
for i = uFaceIDs
    fprintf(fid, 'Person %d (ID: %s) \n', personCounter, i{1});
    for frame = 1:length(files)
        if stringExists(i, files(frame).picasa1.faceIDs) > 0
            fprintf(fid, '%d ', frame);
        end
    end
    fprintf(fid, '\n\n');
    personCounter = personCounter + 1;
end