class Settings
  SETTINGS = YAML.load(File.read "#{Rails.root}/config/settings.yml")[Rails.env.to_sym]

  def self.[](key)
    SETTINGS[key]
  end
end
