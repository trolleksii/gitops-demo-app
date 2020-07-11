git clone https://${_GITHUB_USER}:${_GITHUB_PASSWORD}@github.com/trolleksii/gitops-demo-infra.git --branch dev
cd gitops-demo-infra
git config --global user.name "Google Cloud Build"
git config --global user.email "cbuild@acme.com"
# update config
# imitating image tag variable substitution
sed -i "s/^app = .*$/app = \"$(cat /workspace/tag)\"/g" terraform/main.tfvars
git add terraform/main.tfvars
cat <<EOF | git commit -F-
Update the gitops-demo-app

This commit updates the container image to:
    gcr.io/${PROJECT_ID}/${_APPLICATION_NAME}:$(cat /workspace/tag).

Build ID: ${BUILD_ID}
EOF
git remote get-url origin
git push