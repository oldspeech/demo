docker build -t oldspeech/multi-client:latest -t cygnetops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oldspeech/multi-server:latest -t cygnetops/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oldspeech/multi-worker:latest -t cygnetops/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oldspeech/multi-client:latest
docker push oldspeech/multi-server:latest
docker push oldspeech/multi-worker:latest

docker push oldspeech/multi-client:$SHA
docker push oldspeech/multi-server:$SHA
docker push oldspeech/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oldspeech/multi-server:$SHA
kubectl set image deployments/client-deployment client=oldspeech/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oldspeech/multi-worker:$SHA