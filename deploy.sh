docker build -t oldspeech/multi-client:latest -t cygnetops/multi-client -f ./client/Dockerfile ./client
docker build -t oldspeech/multi-server:latest -t cygnetops/multi-server -f ./server/Dockerfile ./server
docker build -t oldspeech/multi-worker:latest -t cygnetops/multi-worker -f ./worker/Dockerfile ./worker

docker push oldspeech/multi-client:latest
docker push oldspeech/multi-server:latest
docker push oldspeech/multi-worker:latest

docker push oldspeech/multi-client
docker push oldspeech/multi-server
docker push oldspeech/multi-worker

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oldspeech/multi-server
kubectl set image deployments/client-deployment client=oldspeech/multi-client
kubectl set image deployments/worker-deployment worker=oldspeech/multi-worker