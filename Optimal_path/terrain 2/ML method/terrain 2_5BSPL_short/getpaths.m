function paths = getpaths(g)
    %return all paths from a DAG.
    %the function will error in toposort if the graph is not a DAG
    paths = {};     %path computed so far
    endnodes = [];  %current end node of each path for easier tracking
   for nid = toposort(g)    %iterate over all nodes
        if indegree(g, nid) == 0    %node is a root, simply add it for now
            paths = [paths; nid]; %#ok<AGROW>
            endnodes = [endnodes; nid]; %#ok<AGROW>
        end
        %find successors of current node and replace all paths that end with the current node with cartesian product of paths and successors
        toreplace = endnodes == nid;    %all paths that need to be edited
        s = successors(g, nid);
        if ~isempty(s)
            [p, tails] = ndgrid(paths(toreplace), s);  %cartesian product
            paths = [cellfun(@(p, t) [p, t], p(:), num2cell(tails(:)), 'UniformOutput', false);  %append paths and successors
                 paths(~toreplace)];
            endnodes = [tails(:); endnodes(~toreplace)];
        end
   end
end