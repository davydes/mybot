require './lib/motion/webcontrol'
require './lib/motion/files'

class MotionService
  def initialize(options = {})
    @webcontrol = Motion::Webcontrol.new
  end

  def snapshot(options = {})
    cameras = options[:cameras] || [1, 2]
    @files = cameras.map do |cam|
      Motion::Files.new(target_dir: "/var/lib/motion/#{cam}")
    end

    if @webcontrol.snapshot
      sleep(0.5)
      @files.map(&:last_snapshot).compact
    else
      nil
    end
  end

  def last_movie(n)
    @files = Motion::Files.new(target_dir: "/var/lib/motion/#{n}")
    @files.last_movie
  end
end
