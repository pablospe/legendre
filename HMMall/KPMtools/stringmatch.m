function posns = stringmatch(keys, strs)
% STRINGMATCH Find possible matches for strings.
% pos = stringmatch(key, strs) where key is a string and strs is a cell array of strings
% works just like the built-in command pos = strmatch(key, strs, 'exact'). We assume there is
% exactly one occurence of key in strs.
%
% posns = stringmatch(keys, strs), where keys is a cell array of strings, matches each element of keys.

if ~iscell(keys), keys = {keys}; end
nkeys = length(keys);
posns = zeros(1, nkeys);
for i=1:nkeys
  pos = strmatch(keys{i}, strs, 'exact');
  if isempty(pos)
    error(sprintf('%s does not match', keys{i}))
  end
  posns(i) = pos;
end

