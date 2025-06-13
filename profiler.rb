# frozen_string_literal: true

require 'stackprof'
require_relative 'task-1-optimized'

StackProf.run(mode: :wall, out: 'stackprof_reports/stackprof.dump') do
  work
end
