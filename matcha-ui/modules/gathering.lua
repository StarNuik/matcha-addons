local function root()
	local padding = 2
	local font = "Interface\\AddOns\\pfUI\\fonts\\Myriad-Pro.ttf"
	local font_size = 12

	return mui.Center({
		child = mui.Column({
			children = {
				mui.ColoredSized({
					width = 120,
					height = 18,
					color = mui.Color(0, 0, 0),
					child = mui.Padding({
						left = padding,
						right = padding,
						top = padding,
						bottom = padding,
						child = mui.Overlay({
							children = {
								mui.Percent({
									vertical = 1,
									horizontal = 150 / 225,
									child = mui.ColoredGreedy({
										color = mui.Color(.4,.4,.4),
									}),
								}),
								mui.Text({
									text = "150 / 225",
									font = font,
									size = font_size,
									color = mui.Color(1, 1, 1),
								}),
							},
						})
					}),
				}),
				mui.SizedBox({
					width = 120,
					height = 12,
					child = mui.Text({
						text = "Herbalism",
						font = font,
						size = font_size,
						color = mui.Color(1, 1, 1),
					}),
				}),
			},
		})
	})
end


mui.Install(
	root()
)