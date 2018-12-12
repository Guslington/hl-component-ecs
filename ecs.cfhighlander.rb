CfhighlanderTemplate do
  Extends 'asg@1.0.0'

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
    ComponentParam 'FileSystem' if enable_efs
  end

end
