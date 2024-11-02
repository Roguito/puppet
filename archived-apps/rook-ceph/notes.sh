git config --global http.sslVerify "false"
git clone --single-branch --branch master https://github.com/kubernetes-csi/external-snapshotter.git
cd external-snapshotter
kubectl kustomize client/config/crd | kubectl create -f -
kubectl -n kube-system kustomize deploy/kubernetes/snapshot-controller | kubectl -n kube-system create -f -
kubectl kustomize deploy/kubernetes/csi-snapshotter | kubectl -n kube-system create -f -

git clone --single-branch --branch master https://github.com/rook/rook.git
cd rook/deploy/examples
kubectl create -f crds.yaml -f common.yaml -f operator.yaml

kubectl create -f cluster.yaml