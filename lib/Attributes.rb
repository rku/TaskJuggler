#!/usr/bin/env ruby -w
# encoding: UTF-8
#
# = Attributes.rb -- The TaskJuggler III Project Management Software
#
# Copyright (c) 2006, 2007, 2008, 2009 by Chris Schlaeger <cs@kde.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#

require 'Allocation'
require 'AttributeBase'
require 'Charge'
require 'ChargeSet'
require 'Limits'
require 'LogicalOperation'
require 'ShiftAssignments'
require 'WorkingHours'

class TaskJuggler

  class AccountAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def AccountAttribute::tjpId
      'account'
    end

    def to_s
      @value ? '' : @value.id
    end

    def to_tjp
      @value ? '' : @value.id
    end

  end

  class AllocationAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def AllocationAttribute::tjpId
      'allocation'
    end

    def to_tjp
      out = []
      @value.each do |allocation|
        out.push("allocate #{allocation.to_tjp}\n")
        # TODO: incomplete
      end
      out
    end

    def to_s
      out = ''
      first = true
      @value.each do |allocation|
        if first
          first = false
        else
          out << "\n"
        end
        out << '[ '
        firstR = true
        allocation.candidates.each do |resource|
          if firstR
            firstR = false
          else
            out << ', '
          end
          out << resource.fullId
        end
        modes = %w(order lowprob lowload hiload random)
        out << " ] select by #{modes[allocation.selectionMode]} "
        out << 'mandatory ' if allocation.mandatory
        out << 'persistent ' if allocation.persistent
      end
      out
    end

  end

  class BookingListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def BookingListAttribute::tjpId
      'bookinglist'
    end

    def to_s
      @value.collect{ |x| x.to_s }.join(', ')
    end

    def to_tjp
      raise "Don't call this method. This needs to be a special case."
    end

  end

  class BooleanAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def BooleanAttribute::tjpId
      'boolean'
    end

    def to_s
      @value ? 'true' : 'false'
    end

    def to_tjp
      @type.id + ' ' + (@value ? 'yes' : 'no')
    end

  end

  class ChargeListAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def ChargeListAttribute::tjpId
      'charge'
    end

    def to_s
      @value.join(', ')
    end

  end

  # A ChargeSetListAttribute encapsulates a list of ChargeSet objects as
  # PropertyTreeNode attributes.
  class ChargeSetListAttribute < AttributeBase

    def initialize(property, type)
      super

      @value = Array.new
    end

    def ChargeSetListAttribute::tjpId
      'chargeset'
    end

    def to_s
      out = []
      @value.each { |i| out << i.to_s }
      out.join(", ")
    end

    def to_tjp
      out = []
      @value.each { |i| out << i.to_s }
      @type.id + " " + out.join(', ')
    end

  end

  class ColumnListAttribute < AttributeBase

    def initialize(property, type)
      super

      @value = Array.new
    end

    def ColumnListAttribute::tjpId
      'columns'
    end

  end

  class DateAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def DateAttribute::tjpId
      'date'
    end
  end

  class DependencyListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def DependencyListAttribute::tjpId
      'dependencylist'
    end

    def to_s
      out = []
      @value.each { |t| out << t.task.fullId if t.task }
      out.join(', ')
    end

    def to_tjp
      out = []
      @value.each { |taskDep| out << taskDep.task.fullId }
      @type.id + " " + out.join(', ')
    end

  end

  class DurationAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def DurationAttribute::tjpId
      'duration'
    end

    def to_tjp
      @type.id + ' ' + @value.to_s + 'h'
    end

  end

  class FixnumAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def FixnumAttribute::tjpId
      'integer'
    end
  end

  class FlagListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def FlagListAttribute::tjpId
      'flaglist'
    end

    def to_s
      @value.join(', ')
    end

    def to_tjp
      "flags #{@value.join(', ')}"
    end

  end

  class FloatAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def FloatAttribute::tjpId
      'float'
    end

    def to_tjp
      id + ' ' + @value.to_s
    end

  end

  class FormatListAttribute < AttributeBase

    def initialize(property, type)
      super
    end

    def to_s
      @value.join(', ')
    end

  end

  class IntervalListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def IntervalListAttribute::tjpId
      'intervallist'
    end

    def to_s
      out = []
      @value.each { |i| out << i.to_s }
      out.join(", ")
    end

    def to_tjp
      out = []
      @value.each { |i| out << i.to_s }
      @type.id + " " + out.join(', ')
    end

  end

  class LimitsAttribute < AttributeBase

    def initialize(property, type)
      super
    end

    def setProject(project)
      @value.setProject(project)
    end

    def LimitsAttribute::tjpId
      'limits'
    end

    def to_tjp
      'This code is still missing!'
    end

  end

  class LogicalExpressionAttribute < AttributeBase

    def initialize(property, type)
      super
    end

    def LogicalExpressionAttribute::tjpId
      'logicalexpression'
    end

  end

  class PropertyAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def PropertyAttribute::tjpId
      'property'
    end
  end

  class RealFormatAttribute < AttributeBase

    def initialize(property, type)
      super
    end

  end

  class ReferenceAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def ReferenceAttribute::tjpId
      'reference'
    end
  end

  class ResourceListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def ResourceListAttribute::tjpId
      'resourcelist'
    end

    def to_s
      out = []
      @value.each { |r| out << r.fullId }
      out.join(", ")
    end

    def to_tjp
      out = []
      @value.each { |r| out << r.fullId }
      @type.id + " " + out.join(', ')
    end

  end

  class RichTextAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def RichTextAttribute::tjpId
      'richtext'
    end

    def to_tjp
      "#{@type.id} \"#{@value.to_s}\""
    end

  end

  class ScenarioListAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def ScenarioListAttribute::tjpId
      'scenarios'
    end

    def to_s
      @value.join(', ')
    end

  end


  class ShiftAssignmentsAttribute < AttributeBase

    def initialize(property, type)
      super
    end

    def setProject(project)
      @value.setProject(project)
    end

    def ShiftAssignmentsAttribute::tjpId
      'shifts'
    end

    def to_tjp
      'This code is still missing!'
    end

  end

  class SortListAttribute < AttributeBase

    def initialize(property, type)
      super

      @value = Array.new
    end

    def SortListAttribute::tjpId
      'sorting'
    end

  end

  class StringAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def StringAttribute::tjpId
      'text'
    end

    def to_tjp
      "#{@type.id} \"#{@value}\""
    end

  end

  class SymbolAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def SymbolAttribute::tjpId
      'symbol'
    end
  end

  class TaskListAttribute < AttributeBase
    def initialize(property, type)
      super

      @value = Array.new
    end

    def TaskListAttribute::tjpId
      'tasklist'
    end

    def to_s
      out = []
      @value.each { |t, onEnd| out << t.fullId }
      out.join(", ")
    end

    def to_tjp
      out = []
      @value.each { |r| out << r[0].fullId }
      @type.id + " " + out.join(', ')
    end

  end

  class WorkingHoursAttribute < AttributeBase
    def initialize(property, type)
      super
    end

    def WorkingHoursAttribute::tjpId
      'workinghours'
    end

    def to_tjp
      dayNames = %w( sun mon tue wed thu fri sat )
      str = ''
      7.times do |day|
        str += "workinghours #{dayNames[day]} "
        whs = @value.getWorkingHours(day)
        if whs.empty?
          str += "off"
          str += "\n" if day < 6
          next
        end
        first = true
        whs.each do |iv|
          if first
            first = false
          else
            str += ', '
          end
          str += "#{iv[0] / 3600}:#{iv[0] % 3600 == 0 ?
                                    '00' : iv[0] % 3600} - " +
                 "#{iv[1] / 3600}:#{iv[1] % 3600 == 0 ? '00' : iv[1] % 3600}"
        end
        str += "\n" if day < 6
      end
      str
    end

  end

end
