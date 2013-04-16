% Checks whether a string exists in a cell of strings
% Returns the index of the first occurence if it exists

function index = stringExists(stringValue, stringSet)

index = -1;

for i = 1:length(stringSet)
    string = stringSet{i};
    if strcmp(string, stringValue)
        index = i;
        break
    end
end