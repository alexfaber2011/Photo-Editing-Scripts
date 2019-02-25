#!/usr/bin/env ruby

TimelapseExtension = 'timelapse'

def hasJpeg?(filename)
  filename.index(/jp(:?e)?g/i)
end

def hasTimelapse?(filename)
  filename.downcase.include?(TimelapseExtension)
end

def shouldRenameFile?(filename)
  hasJpeg?(filename) and not hasTimelapse?(filename)
end

def appendSuffix(filename)
  filename.split('.').insert(-2, TimelapseExtension).join('.')
end

def renameFile(filename)
  File.rename(filename, appendSuffix(filename))
end

def getAllFilesToBeRenamed
  Dir.entries(Dir.pwd).filter { |filename| shouldRenameFile?(filename) }
end

getAllFilesToBeRenamed().map { |filename| renameFile(filename) }
