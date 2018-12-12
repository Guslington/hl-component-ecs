CfhighlanderTemplate do
  DependsOn 'vpc@1.2.0'
  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
    ComponentParam 'FileSystem' if enable_efs

  end

  Component template: 'asg@1.0.0', name: 'asg', render: Inline

end
