local BACKDROP = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
}
local DEBUG_BACKDROP = {
	edgeFile = "Interface\\Buttons\\WHITE8X8",
	edgeSize = 1,
	-- insets = { left = 1, right = 1, top = 1, bottom = 1, },
}

local ng = {
	child = nil,
}

function mui.engine()
	return ng
end

function ng.component()
	local self = {}
	self.rect = ng.rect(ng.vec2(0, 0), ng.vec2(0, 0))

	function self.set_rect(rect)
		self.rect = rect
	end

	function self.draw_children(offset)
		for _, child in ipairs(self.get_children()) do
			local pos = ng.vec2(offset.x + self.rect.pos.x, offset.y + self.rect.pos.y)
			child.draw(pos)
		end
	end

	function self.draw(offset)
		print("noop: component.draw")
	end

	function self.layout(constr)
		print("noop: component.layout")
		return {0, 0}
	end

	function self.get_children()
		print("noop: component.get_children")
		return {}
	end

	return self
end

function ng.rect(pos, size)
	return { pos = pos, size = size, }
end

function ng.vec2(x, y)
	return { x = x, y = y, }
end

function ng.greedy_layout(constr, child)
	if child then
		local child_size = child.layout(constr)
		child.set_rect(ng.rect(ng.vec2(0, 0), child_size))
	end
	return constr
end

function ng.single_child(child)
	return function() return {child} end
end

function ng.multiple_children(children)
	return function()
		return children or {}
	end
end

-- function ng.layout_sized_box(constr, child, size)
-- 	local size = {
-- 		x = math.min(size.x, constr.x),
-- 		y = math.min(size.y, constr.y),
-- 	}
-- 	if child then
-- 		local child_size = child.layout(size)
-- 		child.set_rect(ng.rect({x = 0, y = 0}, child_size))
-- 	end
-- 	return size
-- end

function ng.ui_parent(child)
	local base = ng.component()
	local self = base
	local pos = ng.vec2(0, 0)
	local size = ng.screen_size()
	self.set_rect(ng.rect(pos, size))

	self.get_children = ng.single_child(child)
	
	function self.layout(constr)
		return ng.greedy_layout(constr, child)
	end

	function self.draw()
		self.draw_children(pos)
	end

	return self
end

function ng.render()
	local tree = ng.layout(ng.child)
	ng.draw(tree)
end

function ng.screen_size()
	return ng.vec2(GetScreenWidth(), GetScreenHeight())
end

function ng.layout(root)
	local tree = ng.ui_parent(root)

	tree.layout(ng.screen_size())
	return tree
end

function ng.draw(tree)
	tree.draw()
	-- local queue = {}
	-- push_back(queue, tree)

	-- while len(queue) > 0 do
	-- 	local curr = pop_front(queue)
	-- 	curr.draw()
	-- 	local children = curr.get_children()
	-- 	for _, child in ipairs(children) do
	-- 		push_back(queue, child)
	-- 	end
	-- end
end

function ng.draw_colored_fill(comp)
	return function(offset)
		local pos = ng.vec2(offset.x + comp.rect.pos.x, offset.y + comp.rect.pos.y)
		local rect = ng.rect(pos, comp.rect.size)
		ng.draw_box(rect, props.color)
		comp.draw_children(offset)
	end
end

function ng.draw_box(rect, color)
	local pos = rect.pos
	local size = rect.size
	
	local f = CreateFrame("Frame")
	f:SetPoint("TOPLEFT", pos.x, -pos.y)
	f:SetWidth(size.x)
	f:SetHeight(size.y)
	f:SetBackdrop(BACKDROP)
	f:SetBackdropColor(color.r, color.g, color.b, color.a)
end

local function draw_debug(pos, size)
	local f = CreateFrame("Frame")
	f:SetPoint("TOPLEFT", pos.x, -pos.y)
	f:SetWidth(size.x)
	f:SetHeight(size.y)
	f:SetBackdrop(DEBUG_BACKDROP)
	f:SetBackdropColor(1, 0, 0)
end

function ng.draw_image(rect, image)
	local pos = rect.pos
	local size = rect.size
	
	local f = CreateFrame("Frame")
	f:SetPoint("TOPLEFT", pos.x, -pos.y)
	f:SetWidth(size.x)
	f:SetHeight(size.y)
	
	local tex = f:CreateTexture()
	tex:SetAllPoints(f)
	tex:SetTexture(image)
end

function ng.draw_text(rect, props)
	local pos = rect.pos
	local size = rect.size

	local f = CreateFrame("Frame")
	f:SetPoint("TOPLEFT", pos.x, -pos.y)
	f:SetWidth(size.x)
	f:SetHeight(size.y)

	local content = props.text or ""
	local font = props.font or "Interface\\AddOns\\matcha-blame\\Fonts\\UbuntuMono-Regular.ttf"
	local size = props.size or 12
	local color = props.color or mui.Color(1, 1, 1)
	
	local text = f:CreateFontString()
	text:SetAllPoints(f)
	text:SetFont(font, size)
	text:SetTextColor(color.r, color.g, color.b, color.a)
	text:SetText(content)
end