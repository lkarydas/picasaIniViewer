function i = faceID2Index(uFaceIDs, fID)
for i = 1:length(uFaceIDs)
    if (strcmp(uFaceIDs{i}, fID))
        return;
    end
end