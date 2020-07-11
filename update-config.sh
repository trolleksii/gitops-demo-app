git config --global user.email "cbuild@acme.com"
git config --global user.name "Google Cloud Build"
echo -n "https://$_GITHUB_USER:$_GITHUB_PASSWORD@github.com/$_GITHUB_USER/gitops-demo-infra.git" > ~/.git-credentials
git config --global credential.helper 'store --file ~/.git-credentials'
git clone https://trolleksii@github.com/trolleksii/gitops-demo-infra.git
cd gitops-demo-infra
git checkout dev
TAG_NAME="$(git describe --tags)"
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