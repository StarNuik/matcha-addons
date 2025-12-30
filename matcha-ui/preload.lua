mui = {}

function clamp(val)
	return min(max(val, 0), 1)
end

function clamp01(val)
	return clamp(val, 0, 1)
end
