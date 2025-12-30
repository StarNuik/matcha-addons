local ng = mui.engine()

function mui.Install(component)
	ng.child = component
end

-- Types
function mui.Color(r, g, b, a)
	if not a then
		a = 1
	end

	return { r = clamp01(r), g = clamp01(g), b = clamp01(b), a = clamp01(a), }
end

-- Layout
function mui.Greedy(props)
	local self = ng.component()
	local child = props.child or nil

	self.get_children = ng.single_child(child)
	self.draw = self.draw_children
	self.layout = function(constr) return ng.greedy_layout(constr, child) end

	return self
end

function mui.Overlay(props)
	local self = ng.component()

	local children = props.children or nil

	self.get_children = ng.multiple_children(children)
	self.draw = self.draw_children

	function self.layout(constr)
		local size = ng.vec2(0, 0)
		for _, child in ipairs(children) do
			local child_size = child.layout(constr)
			child.set_rect(ng.rect(ng.vec2(0, 0), child_size))
			size.x = math.min(constr.x, math.max(size.x, child_size.x))
			size.y = math.min(constr.y, math.max(size.y, child_size.y))
		end
		return size
	end

	return self
end

function mui.SizedBox(props) -- Sized
	local self = ng.component()
	local width = props.width or 0
	local height = props.height or 0
	local size = ng.vec2(width, height)
	local child = props.child or nil

	self.get_children = ng.single_child(child)
	self.draw = self.draw_children
	
	function self.layout(constr)
		local size = {
			x = math.min(size.x, constr.x),
			y = math.min(size.y, constr.y),
		}
		if child then
			local child_size = child.layout(size)
			child.set_rect(ng.rect({x = 0, y = 0}, child_size))
		end
		return size
	end

	return self
end

function mui.Padding(props) -- Greedy
	local self = ng.component()
	local child = props.child or nil
	local top = props.top or 0
	local bottom = props.bottom or 0
	local left = props.left or 0
	local right = props.right or 0

	self.get_children = ng.single_child(child)
	self.draw = self.draw_children
	
	function self.layout(constr)
		local size = ng.vec2(
			constr.x - left - right,
			constr.y - top - bottom
		)
		local child_pos = ng.vec2(left, top)

		if child then
			local child_size = child.layout(size)
			child.set_rect(ng.rect(child_pos, child_size))
		end
		return constr
	end

	return self
end

function mui.Percent(props)
	local self = ng.component()
	local child = props.child or nil
	local vertical = props.vertical or 0
	local horizontal = props.horizontal or 0

	self.get_children = ng.single_child(child)
	self.draw = self.draw_children

	function self.layout(constr)
		local size = ng.vec2(
			constr.x * horizontal,
			constr.y * vertical
		)
		ng.greedy_layout(size, child)
		return size
	end

	return self
end

function mui.Center(props) -- Greedy
	local self = ng.component()
	local child = props.child or nil

	self.get_children = ng.single_child(child)
	self.draw = self.draw_children

	function self.layout(constr)
		if child then
			local child_size = child.layout(constr)
			local center = ng.vec2(constr.x * 0.5, constr.y * 0.5)
			child.set_rect(ng.rect(
				ng.vec2(
					center.x - child_size.x * 0.5,
					center.y - child_size.y * 0.5
				),
				child_size
			))
		end
		return constr
	end

	return self
end

function mui.Column(props)
	local self = ng.component()
	local children = props.children or nil

	self.get_children = ng.multiple_children(children)
	self.draw = self.draw_children

	function self.layout(constr)
		if not children then
			return ng.vec2(0, 0)
		end
	
		local height_used = 0
		local max_width = 0
		for _, child in ipairs(children) do
			local height_left = constr.y - height_used
			local curr_constr = ng.vec2(constr.x, height_left)
			
			local child_size = child.layout(curr_constr)
			local child_pos = ng.vec2(0, height_used)
			child.set_rect(ng.rect(child_pos, child_size))
			
			height_used = height_used + child_size.y
			max_width = math.max(max_width, child_size.x)
		end
		local size = ng.vec2(max_width, height_used)

		for _, child in ipairs(children) do
			local padding_x = (size.x - child.rect.size.x) * 0.5
			child.rect.pos.x = padding_x
		end

		
		return size
	end

	return self
end

function mui.Row(props)
	local self = ng.component()
	local children = props.children or nil

	self.get_children = ng.multiple_children(children)
	self.draw = self.draw_children

	function self.layout(constr)
		if not children then
			return ng.vec2(0, 0)
		end
	
		local width_used = 0
		local max_height = 0
		for _, child in ipairs(children) do
			local width_left = constr.x - width_used
			local curr_constr = ng.vec2(width_left, constr.y)
			
			local child_size = child.layout(curr_constr)
			local child_pos = ng.vec2(width_used, 0)
			child.set_rect(ng.rect(child_pos, child_size))
			
			width_used = width_used + child_size.x
			max_height = math.max(max_height, child_size.y)
		end
		local size = ng.vec2(width_used, max_height)

		for _, child in ipairs(children) do
			local padding_y = (size.y - child.rect.size.y) * 0.5
			child.rect.pos.y = padding_y
		end

		
		return size
	end

	return self
end

-- Rendering
function mui.ColoredGreedy(props) -- Greedy
	local self = mui.Greedy(props)
	local color = props.color or mui.Color(1, 0, 1)

	function self.draw(offset)
		local pos = ng.vec2(offset.x + self.rect.pos.x, offset.y + self.rect.pos.y)
		local rect = ng.rect(pos, self.rect.size)
		ng.draw_box(rect, color)
		self.draw_children(offset)
	end

	return self
end

function mui.ColoredSized(props)
	return mui.SizedBox({
		width = props.width,
		height = props.height,
		child = mui.ColoredGreedy(props),
	})
end

function mui.Image(props)
	local self = mui.Greedy(props)
	local image = props.image or nil

	self.get_children = function() return {} end
	
	function self.draw(offset)
		local pos = ng.vec2(offset.x + self.rect.pos.x, offset.y + self.rect.pos.y)
		local rect = ng.rect(pos, self.rect.size)
		ng.draw_image(rect, image)
	end

	return self
end

function mui.SizedImage(props)
	return mui.SizedBox({
		width = props.width,
		height = props.height,
		child = mui.Image({
			image = props.image,
		})
	})
end

function mui.Text(props)
	local self = mui.Greedy(props)

	self.get_children = function() return {} end

	function self.draw(offset)
		local pos = ng.vec2(offset.x + self.rect.pos.x, offset.y + self.rect.pos.y)
		local rect = ng.rect(pos, self.rect.size)
		ng.draw_text(rect, props)
	end

	return self
end