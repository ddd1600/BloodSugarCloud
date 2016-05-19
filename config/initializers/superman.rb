require 'csv'

#number classes

class Float
  def number_decimal_places
    self.to_s.length-2
  end
  
  def to_fraction
    higher = 10**self.number_decimal_places
    lower = self*higher

    gcden = greatest_common_divisor(higher, lower)

    return (lower/gcden).round, (higher/gcden).round
  end
  
private

  def greatest_common_divisor(a, b)
     while a%b != 0
       a,b = b.round,(a%b).round
     end 
     return b
  end
end


class Array
  
  def stats(awesomeprint=true) #, hsh_for_convert=nil) <-- I forgot what this does so removed it for now
    count = Hash.new(0)
    self.each do |str|
      count[str] += 1
    end
    stats = count.sort_by{|k, v| v}.reverse
    total = self.count.to_f
    x = stats.map { |value, freq| [value, freq, "#{(freq.to_f / total * 100).round(1)}%"] }.sort_by{|k,v| v}
    if awesomeprint
      ap x
    else
      x
    end
  end
  
  def like(this, these=nil)
    select {|s| s=~ /#{this}/}
  end
  
  def popdrop(n)
    x = self
    x.pop(n)
    x
  end
  
  def exclude(obj)
    x = self
    x.delete(obj)
    x
  end
  
  def pluck(keyvalue)
    if self.first.first.is_a?(Symbol)
      self.map{ |x| x[keyvalue.to_sym]  }  
    else
      self.map{ |x| x[keyvalue] }
    end
  end
end

module Enumerable

    def sum
      self.inject(0){|accum, i| accum + i }
    end

    def mean
      self.compact.sum/self.compact.length.to_f
    end
    
    def average
      mean
    end

    def sample_variance
      m = self.mean
      sum = self.inject(0){|accum, i| accum +(i-m)**2 }
      sum/(self.length - 1).to_f
    end

    def standard_deviation
      return Math.sqrt(self.sample_variance)
    end
    
    def median
      if self.count > 1
        sorted = self.compact.sort
        len = sorted.length
        return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
      elsif self.count == 0
        self
      else
        nil
      end
    end

end

class Hash
   def to_params
     self.map { |k,v| "#{k}=#{v}" }.join("&")
   end
end

class String
  def url_encode
    self.gsub(" ", "%20").gsub("'", "%27").gsub(",", "%2C")
  end
end


def commit(msg)
  msg = msg.gsub(" ")
  `git commit -a -m '#{msg}'`
end

def add
  `git add -A`
end

def push(branch="master")
  `git push origin #{branch}`
end

def openf
  `open .`
end

def migration(name)
  `rails g migration #{name.gsub(' ', '_')}`  
  latestmigration
end

def latestmigration
  puts "#{Dir.glob(File.join(Rails.root, 'db', 'migrate', '*.rb')).max { |a,b| File.ctime(a) <=> File.ctime(b)} }"
end

def secondlatestmigration
  first = Dir.glob(File.join(Rails.root, 'db', 'migrate', '*.rb')).max { |a,b| File.ctime(a) <=> File.ctime(b)}
  second = (Dir.glob(File.join(Rails.root, 'db', 'migrate', '*.rb')) - [first]).max { |a,b| File.ctime(a) <=> File.ctime(b)}
  puts "#{second}"
end

def migrate
  `rake db:migrate`
end

def rollback
  `rake db:rollback`
  latestmigration
end

def doublerollback
  rollback
  latestmigration
  rollback
  secondlatestmigration
end