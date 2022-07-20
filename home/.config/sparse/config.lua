bind('e', 'visual', run_all(start_edit, deselect_message, switch_mode("insert-line")))

bind('a', 'visual', function(c)
	os.execute("rofi -mode emoji -show emoji")
	content = c:get_clipboard()
	return c:react(content)
end)

bind('ss', 'normal', function(c)
	file = os.tmpname() .. ".png"
	os.execute("flameshot gui -p " .. file)
	return c:send_file(file)
end)
