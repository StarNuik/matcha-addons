local function rainbow_row(child)
	return mui.Row({
		children = {
			mui.ColoredBox({
				width = 12,
				height = 12,
				color = mui.Color(1, 0, 0)
			}),
			mui.ColoredBox({
				width = 25,
				height = 25,
				color = mui.Color(1, .5, 0)
			}),
			mui.ColoredBox({
				width = 50,
				height = 50,
				color = mui.Color(1, 1, 0),
				child = mui.Text({
					text = "BIG MEOW",
					color = mui.Color(0, 0, 0),
				}),
			}),
			mui.ColoredBox({
				width = 100,
				height = 100,
				color = mui.Color(0, .8, 0),
				child = child,
			}),
			mui.ColoredBox({
				width = 50,
				height = 50,
				color = mui.Color(0, 1, 1),
				child = mui.Text({
					text = "smol meow",
					color = mui.Color(0, 0, 0)
				}),
			}),
			mui.ColoredBox({
				width = 25,
				height = 25,
				color = mui.Color(0, 0, 1)
			}),
			mui.ColoredBox({
				width = 12,
				height = 12,
				color = mui.Color(1, 0, 1)
			}),
		}
	})
end

local function grayscale_row(child)
	return mui.Row({
		children = {
			mui.ColoredBox({
				width = 12,
				height = 12,
				color = mui.Color(0, 0, 0)
			}),
			mui.ColoredBox({
				width = 25,
				height = 25,
				color = mui.Color(.166, .166, .166)
			}),
			mui.ColoredBox({
				width = 50,
				height = 50,
				color = mui.Color(.333, .333, .333),
				child = mui.Text({
					text = "Hello",
				}),
			}),
			mui.ColoredBox({
				width = 100,
				height = 100,
				color = mui.Color(.5, .5, .5),
				child = child,
			}),
			mui.ColoredBox({
				width = 50,
				height = 50,
				color = mui.Color(.666, .666, .666),
				child = mui.Text({
					text = "world!",
				}),
			}),
			mui.ColoredBox({
				width = 25,
				height = 25,
				color = mui.Color(.833, .833, .833)
			}),
			mui.ColoredBox({
				width = 12,
				height = 12,
				color = mui.Color(1, 1, 1)
			}),
		},
	})
end

local function small_emoji()
	return mui.SizedImage({
		width = 25,
		height = 25,
		image = "Interface\\AddOns\\matcha-ui\\emoji-2",
	})
end

local function emoji_pyramid()
	return mui.Center({
		child = mui.Column({
			children = {
				mui.Row({ children = {small_emoji()}, }),
				mui.Row({ children = {small_emoji(), small_emoji()}, }),
				mui.Row({ children = {small_emoji(), small_emoji(), small_emoji()}, }),
			},
		})
	})
end

local function centered_emoji()
	return mui.Center({
		child = mui.SizedImage({
			height = 75,
			width = 75,
			image = "Interface\\AddOns\\matcha-ui\\emoji-1",
		})
	})
end

-- mui.Install(
-- 	mui.Center({
-- 		child = mui.Column({
-- 			children = {
-- 				rainbow_row(
-- 					centered_emoji()
-- 				),
-- 				grayscale_row(
-- 					emoji_pyramid()
-- 				),
-- 			}
-- 		})
-- 	})
-- )



local ng = mui.engine()
ng.render()

-- function mui.Color(r, g, b, a)
-- 	if not a then
-- 		a = 1
-- 	end
-- 	return { clamp01(r), clamp01(g), clamp01(b), clamp01(a), }
-- end

-- function mui.Rect(pos, size)
-- 	return {pos, size}
-- end

-- function component(props)
-- 	local self = {}
-- 	local pos = {0, 0}
-- 	local size = {0, 0}

-- 	function self.layout(constr)
-- 		print("not implemented: component.layout")
-- 		return {0, 0}
-- 	end

-- 	function self.paint(pos)
-- 		print("not implemented: component.paint")
-- 	end

-- 	function self.get_children()
-- 		print("not implemented: component.get_children")
-- 		return {}
-- 	end

-- 	function self.set_renderer_rect(rect)
-- 		print("not implemented: component.set_renderer_rect")
-- 	end

-- 	return self
-- end

-- function mui.SizedBox(props)
-- 	return component({name = "SizedBox"})
-- end

-- function mui.Column(props)
-- 	local self = component({name = "Column"})
-- 	local rect_pos = {0, 0}
-- 	local rect_size = {0, 0}

-- 	function self.layout(constr)
-- 		print("layout", "Column")
-- 		local height_used = 0
-- 		local max_width = 0
-- 		for idx, child in ipairs(props.children) do
-- 			local height_left = constr[2] - height_used
-- 			local child_size = child.layout({constr[1], height_left})
-- 			child.set_renderer_rect(
-- 				mui.Rect({0, height_used}, child_size)
-- 			)
-- 			height_used = height_used + child_size[2]
-- 			max_width = math.max(max_width, child_size[1])
-- 		end
-- 		return {constr[1], math.min(constr[2], max_width)}
-- 	end

-- 	function self.get_children()
-- 		return props.children
-- 	end

-- 	function self.set_renderer_rect(rect)
-- 	end

-- 	return self
-- end

-- function mui.ColoredBox(props)
-- 	local self = component({name = "ColoredBox"})
-- 	local rect_pos = {0, 0}
-- 	local rect_size = {0, 0}
	
-- 	function self.layout(constr)
-- 		print("layout", "ColoredBox")
-- 		local size = {
-- 			math.min(props.width, constr[1]),
-- 			math.min(props.height, constr[2]),
-- 		}

-- 		if props.child then
-- 			local child = props.child
-- 			local child_size = child.layout(size)
-- 			child.set_renderer_rect({0, 0}, child_size)
-- 		end
-- 		return size
-- 	end

-- 	function self.get_children()
-- 		return {props.child}
-- 	end

-- 	function self.paint()
-- 		local color = props.color

-- 		local f = CreateFrame("Frame")
-- 		f:SetPoint("TOPLEFT", rect_pos[1], -rect_pos[2])
-- 		f:SetWidth(rect_size[1])
-- 		f:SetHeight(rect_size[2])
-- 		f:SetBackdrop(backdrop)
-- 		f:SetBackdropColor(color[1], color[2], color[3], color[4])
-- 	end

-- 	function self.set_renderer_rect(rect)
-- 		rect_pos = {rect[1], rect[2]}
-- 		rect_size = {rect[3], rect[4]}
-- 	end

-- 	return self
-- end

-- local function build_ui()
-- 	return mui.ColoredBox({
-- 		width = 100,
-- 		height = 200,
-- 		color = mui.Color(0, 0, 0),
-- 		child = mui.Column({
-- 			children = {
-- 				mui.ColoredBox({
-- 					width = 50,
-- 					height = 50,
-- 					color = mui.Color(1, .5, .5),
-- 				}),
-- 				mui.ColoredBox({
-- 					width = 75,
-- 					height = 75,
-- 					color = mui.Color(.5, .5, 1),
-- 				}),
-- 				mui.ColoredBox({
-- 					width = 150,
-- 					height = 25,
-- 					color = mui.Color(.5, 1, .5),
-- 				}),
-- 				mui.ColoredBox({
-- 					width = 25,
-- 					height = 150,
-- 					color = mui.Color(1, 1, 1),
-- 				}),
-- 			},
-- 		}),
-- 	})
-- end

-- function ui_parent(props)
-- 	local self = component({name = "ui_parent", })
	
-- 	function self.layout(constr)
-- 		print("layout", "ui_parent")

-- 		local child = props.child
-- 		local child_size = child.layout(constr)
-- 		child.set_renderer_rect({0, 0}, child_size)
-- 		return constr
-- 	end

-- 	function self.get_children()
-- 		return {props.child}
-- 	end

-- 	return self
-- end

-- function layout(build)
-- 	local screen_constraint = {1920, 1080}
-- 	local tree = ui_parent({ child = build(), })

-- 	tree.layout(screen_constraint)
-- 	tree.set_renderer_rect({0, 0}, screen_constraint)
-- 	return tree
-- end

-- function paint(tree)
-- 	local queue = {}
-- 	push_back(queue, tree)

-- 	while len(queue) > 0 do
-- 		local curr = pop_front(queue)
-- 		curr.paint()
-- 		local children = curr.get_children()
-- 		for _, child in ipairs(children) do
-- 			push_back(queue, child)
-- 		end
-- 	end
-- end

-- local tree = layout(build_ui)
-- paint(tree)
-- function component.Layout(constr)
-- 	local leftover_constr = constr
-- 	for _, child in ipairs(self.children)
-- 		local child_size = child.Layout(leftover_constr)
-- 		self.pos[child] = self.position_child()
-- 		leftover_constr = leftover_constr - child_size
-- 	end
-- 	return self.size(leftover_constr)
-- end

-- function component.Paint(pos)
-- 	self.internal_paint(pos)
-- 	local curr_pos = pos
-- 	for _, child in ipairs(self.children)
-- 		child.Paint(curr_pos)
-- 		curr_pos = curr_pos - self.size[child]
-- 	end
-- end