require 'json'
class Storage
  def self.save_data(obj, key)
    path = File.join(File.dirname(__FILE__), "#{key}.json")
    begin
      File.write(path, JSON.generate(obj))
    rescue StandardError => e
      puts "Failed to save the file #{e.message}"
      nil
    end
    true
  end

  def self.load_data(key)
    file_path = File.join(File.dirname(__FILE__), "#{key}.json")
    begin
      file = File.open(file_path)
      JSON.parse(file.read)
    rescue Errno::ENOENT => e
      puts "File not found: #{e.message}"
      nil
    ensure
      file&.close
    end
  end
end
