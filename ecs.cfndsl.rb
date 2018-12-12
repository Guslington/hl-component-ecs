CloudFormation do

  Description "#{component_name} - #{component_version}"

  if enable_efs
    user_data << "mkdir /efs\n"
    user_data << "yum install -y nfs-utils\n"
    user_data << "mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${FileSystem}.efs.${AWS::Region}.amazonaws.com:/ /efs\n"
  end

  ecs_agent_extra_config.each do |key,value|
    user_data << "#{key}=#{value} >> /etc/ecs/ecs.config\n"
  end if defined? ecs_agent_extra_config


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
