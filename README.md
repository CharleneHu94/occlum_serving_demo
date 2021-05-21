# Analytics Zoo Cluster Serving Inference in SGX with Occlum #

This example demonstrates how to use Analytics Zoo Cluster Serving for real-time inference in SGX. 
[Analytics Zoo](https://github.com/intel-analytics/analytics-zoo) is an open source Big Data AI platform, [Cluster Serving](https://www.usenix.org/conference/opml20/presentation/song) is a real-time serving solution that enables automatic model inference on Flink cluster.

Note that in this example all components are run on single machine within one container. For running cluster serving with SGX on multi-nodes, please refer to [distributed mode](https://github.com/intel-analytics/analytics-zoo/tree/master/ppml/trusted-realtime-ml/scala/docker-occlum#distributed-mode-multi-containersmulti-nodes) in Analytics Zoo doc.

## Install Dependencies ##
Download and install dependencies (Redis, Flink, Analytics Zoo, models)

    ./install-dependencies.sh
## Start Cluster Serving ##
Start Redis, Flink and cluster serving

	./start-all.sh
Or you can start components separately:


1. **Start Redis Server**

    `./start-redis.sh`


2. **Start Flink**

	Start Flink Jobmanager on host

	`./start-flink-jobmanager.sh`

	Initialize and start Flink Taskmanager with Occlum
	
	``` 
	./init-occlum-taskmanager.sh  			
	./start-flink-taskmanager.sh
	```
   
3. **Start Cluster Serving job**

	Start HTTP frontend
	
	`./start-http-frontend.sh`
    
	Start cluster serving job
	
	`./start-cluster-serving-job.sh`

## Push inference image ##
Push image into queue via Restful API for inference

    ./push-image.sh
## Stop Cluster Serving ##
Stop cluster serving job and all components
	
	./stop-all.sh