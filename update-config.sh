git config --global user.email "cbuild@acme.com"
git config --global user.name "Google Cloud Build"
# echo -n "https://$_GITHUB_USER:$_GITHUB_PASSWORD@github.com/$_GITHUB_USER/gitops-demo-infra.git" > /workspace/.git-credentials
git clone https://$_GITHUB_USER:$_GITHUB_PASSWORD@github.com/trolleksii/gitops-demo-infra.git --branch dev
cd gitops-demo-infra
# git config --global credential.helper 'store --file /workspace/.git-credentials'
git fetch --all --tags
git tag -l
export TAG_NAME="$(git describe --tags)"
# update config
# imitating image tag variable substitution
sed -i "s/^app = .*$/app = \"$TAG_NAME\"/g" terraform/main.tfvars
git add terraform/main.tfvars
cat <<EOF | git commit -F-
Update the gitops-demo-app

This commit updates the container image to:
    gcr.io/$PROJECT_ID/$_APPLICATION_NAME:$TAG_NAME.

Build ID: $BUILD_ID
EOF
git tag $TAG_NAME
git push --tags
git push origin dev