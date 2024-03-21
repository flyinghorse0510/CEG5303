function [wayPoints] = gen_arbitrary_trace(targetString, positionBias, scaleFactor)

N = {
    '*    *'
    '*   **'
    '*  * *'
    '* *  *'
    '*    *'
};
U = {
    '*    *'
    '*    *'
    '*    *'
    '*    *'
    '******'
};
S = {
    '******'
    '*     '
    '******'
    '     *'
    '******'
};
% currently supported character
charPositionMap = containers.Map;
charPositionMap('N') = [0, 1, 0; 0, 0, 0; 1, 1, 0; 1, 0, 0] + positionBias;
charPositionMap('U') = [0, 1, 0; 0, 0, 0; 1, 0, 0; 1, 1, 0] + positionBias;
charPositionMap('S') = [1, 1, 0; 0, 1, 0; 0, 0.5, 0; 1, 0.5, 0; 1, 0, 0; 0, 0, 0] + positionBias;

% convert string to char
targetCharArray = targetString.char();
wayPoints = [];
for i = 1:strlength(targetString)
    char = targetCharArray(i);
    charWayPoints = charPositionMap(char);
    if isempty(wayPoints)
        wayPoints = charWayPoints * scaleFactor;
    else
        wayPoints = cat(1, wayPoints, charWayPoints * scaleFactor + (i-1)*[1.5, 0, 0]*scaleFactor);
    end
end

end