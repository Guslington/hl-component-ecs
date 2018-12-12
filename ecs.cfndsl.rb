CloudFormation do

  Description "#{component_name} - #{component_version}"

  ECS_Cluster('EcsCluster') {
    ClusterName FnSub("${EnvironmentName}-#{cluster_name}") if defined? cluster_name
  }

  Logs_LogGroup('LogGroup') {
    LogGroupName Ref('AWS::StackName')
    RetentionInDays "#{log_group_retention}"
  }

  Output("EcsCluster") {
    Value(Ref('EcsCluster'))
    Export FnSub("${EnvironmentName}-#{component_name}-EcsCluster")
  }
  Output("EcsClusterArn") {
    Value(FnGetAtt('EcsCluster','Arn'))
    Export FnSub("${EnvironmentName}-#{component_name}-EcsClusterArn")
  }

end
