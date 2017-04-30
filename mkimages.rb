#!/usr/bin/env ruby
require 'fileutils'

Dir.chdir("assets/images")
Dir.glob("**/*.xcf").each do |f|
	fname = "../../code/River_Raid/images/#{f.gsub(/xcf$/,"png")}"
	if !File.exists? fname or File.mtime(f) > File.mtime(fname)
		FileUtils.mkpath(fname.gsub(%r|/[^/]+$|,""))
		cmd = "xcf2png #{f} > #{fname}"
		puts cmd
		`#{cmd}`
	end
end
