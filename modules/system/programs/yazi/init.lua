require("relative-motions"):setup({ show_numbers="relative", show_motion = true, enter_mode ="first" })

require("recycle-bin"):setup()

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	-- elseif os.date("%Y", time) == os.date("%Y") then
	-- 	time = os.date("%H:%M | %d %b", time)
	else
		time = os.date("%H:%M | %d.%m.%Y", time)
	end

	local size = self._file:size()
	return string.format("%s | %s", size and ya.readable_size(size) or "-", time)
end

function Linemode:size_and_btime()
	local time = math.floor(self._file.cha.btime or 0)
	if time == 0 then
		time = ""
	else
		time = os.date("%H:%M | %d.%m.%Y", time)
	end

	local size = self._file:size()
	return string.format("%s | %s", size and ya.readable_size(size) or "-", time)
end
