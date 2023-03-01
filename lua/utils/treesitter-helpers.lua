local M = {}

--- Returns a list-like table for all the parent nodes of a node
---@param node TSNode a tree-sitter node
---@return TSNode[] a list of tree-sitter nodes
M.get_all_parent_nodes = function(node)
	local result = {}
	local immediate_parent = node:parent() or nil
	if not immediate_parent then
		return result
	end
	table.insert(result, immediate_parent)
	-- recursively look through all
	local ancestors = M.get_all_parent_nodes(immediate_parent)
	for _, parent in ipairs(ancestors) do
		table.insert(result, parent)
	end
	return result
end

return M
