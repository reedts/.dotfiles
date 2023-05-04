user("reedts")
host("https://matrix.intxeighty.de")

bind('e', 'visual', run_all(start_edit, deselect_message, switch_mode("insert-line")))
bind('d', 'visual', delete_message)

bind('a', 'visual', function(c)
	local pipe = io.popen("BEMOJI_PICKER_CMD='fuzzel --dmenu --log-level=none' bemoji -P -e")

	if pipe == nil then
		error("Failed to run emoji selector")
	end

	local content = string.gsub(pipe:read("*a"), "\n", "")
	pipe:close()
	if content == nil or content == "" then
		error("No content")
	end

	return c:react(content)
end)

bind('ss', 'normal', function(c)
	local file = os.tmpname() .. ".png"
	os.execute("slurp | grim -g - " .. file)
	return c:send_file(file)
end)
