#!/usr/bin/env ruby

require 'fileutils'

input, outdir, logfile = ARGV
FileUtils.mkdir_p(outdir)
FileUtils.mkdir_p(File.dirname(logfile))

content = File.read(input)
tasks = content.split(/^---\s*$/)
log = []

tasks.each do |task|
  if task =~ /### Tarea\s+([0-9a-z]+):\s+(.*)/
    id = Regexp.last_match(1)
    title = Regexp.last_match(2).strip.gsub(/[^\w\s-]/, '').gsub(/\s+/, '_')
    filename = "#{id}-#{title}.md"
    filepath = File.join(outdir, filename)
    File.write(filepath, task.strip + "\n")
    log << "📝 #{filename}"
  end
end

File.write(logfile, log.join("\n") + "\n")
puts log
puts "✅ Completado."
