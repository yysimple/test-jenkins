pipeline {
    agent {
        node {
            label 'maven'
        }

    }
    stages {
        stage('拉取代码') {
            agent none
            steps {
                container('maven') {
                    sh 'ls -al'
                    git(url: 'https://gitee.com/yysimple/test-jenkins.git', credentialsId: 'gitee-id', branch: 'master', changelog: true, poll: false)
                    sh 'ls -al'
                }

            }
        }

        stage('编译项目') {
            agent none
            steps {
                container('maven') {
                    sh 'mvn clean install -Dmaven.test.skip=true'
                    sh 'ls -al'
                    sh 'ls -al target/'
                }

            }
        }

        stage('构建镜像') {
            agent none
            steps {
                container('maven') {
                    sh 'docker build -t test-jenkins:latest -f Dockerfile .'
                    sh 'docker images'
                }

            }
        }

        stage('推送镜像') {
            agent none
            steps {
                container('maven') {
                    sh 'docker tag  test-jenkins:latest $REGISTRY/$DOCKERHUB_NAMESPACE/test-jenkins:SNAPSHOT-$BUILD_NUMBER'
                    withCredentials([usernamePassword(credentialsId : 'docker-harbor' ,passwordVariable : 'DOCKER_HARBOR_PWD' ,usernameVariable : 'DOCKER_HARBOR_USER' ,)]) {
                        sh 'echo "$DOCKER_HARBOR_PWD" | docker login $REGISTRY -u "$DOCKER_HARBOR_USER" --password-stdin'
                        sh 'docker push $REGISTRY/$DOCKERHUB_NAMESPACE/test-jenkins:SNAPSHOT-$BUILD_NUMBER'
                    }

                }

            }
        }

    }
    environment {
        DOCKER_CREDENTIAL_ID = 'dockerhub'
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig'
        REGISTRY = '192.168.31.110:8084'
        DOCKERHUB_NAMESPACE = 'test'
        APP_NAME = 'test-jenkins'
        SONAR_CREDENTIAL_ID = 'sonar-token'
    }
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: '')
    }
}