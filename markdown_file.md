**User document: Telepresence workflows**

-   #### [1.1. Introduction]{.underline}

-   [1.2. Before you begin]{.underline}

    -   [1.2.1. K8s cluster setup using minikube]{.underline}

    -   [1.2.2. Source code for the examples used in the
        walkthrough.]{.underline}

-   [1.3. Installing telepresence]{.underline}

    -   [1.3.1. Installing telepresence traffic manager on your K8s
        cluster]{.underline}

    -   [1.3.2. Installing telepresence daemon on the
        workstation]{.underline}

>  [1.3.2.1. Linux]{.underline}
>
>  [1.3.2.2. macOS]{.underline}
>
>  [1.3.2.3. Windows]{.underline}

-   [1.4. Workflow 1: Using telepresence to develop code on the K8s
    cluster from your]{.underline} [workstation]{.underline}

    -   [1.4.1. Steps to create the example1 one deployment on K8s
        cluster]{.underline}

    -   [1.4.2. Steps to run the example1 code on your
        workstation]{.underline}

    -   [1.4.3. Steps to use Telepresence for developing the code live
        on the cluster]{.underline}

-   [1.5. Workflow 2: Using telepresence to set up your local
    development workspace]{.underline}

    -   [1.5.1. Steps to create the example2 deployment on K8s
        cluster]{.underline}

    -   [1.5.2. Steps to use telepresence for setting up your local
        development workspace]{.underline}

-   [1.6. Workflow 3: Using telepresence to debug your code at the K8s
    cluster level]{.underline}

    -   [1.6.1. Steps to create the example3 one deployment on the K8s
        cluster]{.underline}

    -   [1.6.2. Steps to run the example3 code on your
        workstation]{.underline}

    -   [1.6.3. Steps to use telepresence to debug your code at the K8s
        cluster level]{.underline}

-   [1.7. Workflow 4: Using telepresence for automated testing of
    cloud-native code]{.underline}

    -   [1.7.1. Steps to create the example4 deployment on K8s
        cluster]{.underline}

    -   [1.7.2. Steps to create a script to test the K8s workloads with
        telepresence]{.underline}

    1.  **Introduction**

> Modern microservices-based applications that are deployed into
> Kubernetes often consist of tens or hundreds of services. The resource
> constraints and a number of these services mean that it is often
> difficult or impossible to run all of this on a local development
> machine, which makes fast development and debugging very challenging.
>
> [Telepresence]{.underline} enables you to connect your local
> development machine seamlessly to the K8s cluster via a two-way
> proxying mechanism. This enables you to code locally and run the
> majority of your services within a K8s cluster.
>
> This document provides walkthroughs to utilize telepresence in local
> development.

2.  **Before you begin**

> We need a K8s cluster to follow the workflow demonstrations. We
> recommend minikube for creating the K8s cluster on your workstation

1.  **K8s cluster setup using minikube**

    1.  [Install minikube]{.underline}

    2.  To create a minikube cluster run

> minikube start

### Source code for the examples used in the walkthrough.

#### To follow along with the walkthrough with the same examples showcased in upcoming sections, please download the [source code]{.underline}

\# you can clone/download the source code in the following ways:

1)  Go to https://github.mathworks.com/development/iatcp-telepresence-
    maheshp/tree/telepresence-examples-v1 (will be changed after merge
    of pull branch) -\> Code -\> Download zip -\> extract the code from
    zip

(In this case the souce code will be in folder
\"iatcp-telepresence-maheshp- telepresence-examples-v1\" )

2)  \$ git clone
    https://github.mathworks.com/development/iatcp-telepresence-
    maheshp.git -b telepresence-examples-v1

(In this case the souce code will be in folder
\"iatcp-telepresence-maheshp\" )

1.  Installing telepresence
    =======================

    1.  Installing telepresence traffic manager on your K8s cluster
        -----------------------------------------------------------

#### We will be using Helm to install the telepresence traffic manager on your K8s cluster. If you do not have the helm, you can install it from [here]{.underline}. Next, follow the below steps

1.  Add the Required helm repository

> \$ helm repo add mw-helm [http://mw-helm-](http://mw-helm-/)
> repository.mathworks.com/artifactory/mw-helm \"mw-helm\" has been
> added to your repositories

#### Create ambassador namespace

> 3\. \$ kubectl create namespace ambassador namespace/ambassador
> created

#### 4. Run the below commands to deploy the telepresence traffic manager to your K8s cluster.

5.  \#Obtain the values.yaml file

6.  \#You can find the values.yaml file in the directory
    iatcp-telepresence-
    maheshp-telepresence-examples-v1/traffic-manager-helm-
    values/values.yaml, if you have downloaded the source code. If not
    run the below command with your access token

7.  \$curl
    https://github.mathworks.com/raw/development/iatcp-telepresence-
    maheshp/telepresence-examples-v1/traffic-manager-helm-
    values/values.yaml?token=\<your access token\> \>values.yaml

> 8\.
>
> 9\.

10. \#The below command deploys the telepresence traffic manager with
    configurations in values.yaml

11. \$ helm install traffic-manager \--namespace ambassador mw-
    helm/telepresence \--version 2.10.4 -f values.yaml

12. NAME: traffic-manager

13. LAST DEPLOYED: Tue Apr 4 15:05:53 2023

14. NAMESPACE: ambassador

15. STATUS: deployed

16. REVISION: 1

17. NOTES:

> 18\.
> \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--
>
> \-\-\-\-\-\-\-\-\--
>
> 19\. Congratulations! 20.
>
> 21\.

22. You have successfully installed the Traffic Manager component of
    Telepresence!

23. Now your users will be able to \`telepresence connect\` to this
    Cluster and create

24. intercepts for their services! 25.

    1.  Installing telepresence daemon on the workstation
        -------------------------------------------------

#### Install Telepresence by running the respective commands below for your OS

1.  **Linux**

\# 1.Copy telepresence binary from

//mathworks/hub/3rdparty/internal/9506312/glnxa64/Telepresence/ to any
buffer directory (the binary will be moved to actual path in 3rd step)

\$ cp

//mathworks/hub/3rdparty/internal/9506312/glnxa64/Telepresence/telepresence

\~/Downloads

\# 2.Make it an executable

\$ chmod a+x \~/Downloads/telepresence

\# 3.Move the file to /usr/local/bin

\$ sudo mv \~/Downloads/telepresence /usr/local/bin/

2.  **macOS**

\# Intel Macs

\# 1. Copy telepresence binary from

//mathworks/hub/3rdparty/internal/9506312/maci64/Telepresence to any
buffer directory (the binary will be moved to actual path in next step)

\$ cp

//mathworks/hub/3rdparty/internal/9506312/maci64/Telepresence/telepresence

\~/Downloads

\# 2.Move the file to /usr/local/bin

\$sudo mv \~/Downloads/telepresence /usr/local/bin

\# Apple silicon Macs

\# 1. Copy telepresence binary from

//mathworks/hub/3rdparty/internal/9506312/maca64/Telepresence to any
buffer directory (the binary will be moved to actual path in next step)

\$ cp

//mathworks/hub/3rdparty/internal/9506312/maca64/Telepresence/telepresence

\~/Downloads

\# 2.Move the file to /usr/local/bin

\$sudo mv \~/Downloads/telepresence /usr/local/bin

### Windows

\# To install Telepresence, run the following commands in PowerShell as
admin

\# 1. Copy telepresence zip file from
3rdparty/internal/9506312/win64/Telepresence to any buffer directory
(the binary will be moved to actual path in 3rd step)

PS C:\\Users\\maheshp\> cp

\\\\mathworks\\BGL\\hub\\3rdparty\\internal\\9506312\\win64\\Telepresence\\telepresence

.zip .\\Downloads\\

\# 2.Navigate to the folder containing the downloaded file and unzip the
telepresence.zip file to the desired directory, then remove the zip file
PS C:\\Users\\maheshp\\Downloads\> Expand-Archive -Path telepresence.zip
- DestinationPath telepresenceInstaller/telepresence

PS C:\\Users\\maheshp\\Downloads\>Remove-Item \'telepresence.zip\'

PS C:\\Users\\maheshp\\Downloads\> cd
.\\telepresenceInstaller\\telepresence\\

\# 3. Run the install-telepresence.ps1 to install telepresence\'s
dependencies. It will install telepresence to

\# C:\\telepresence by default, but you can specify a custom path by
passing in

-Path C:\\my\\custom\\path

PS C:\\Users\\maheshp\\Downloads\\telepresencInstaller\\telepresence\\\>
powershell.exe -ExecutionPolicy bypass -c \" .
\'.\\install-telepresence.ps1\';\"

\# 4. Remove the unzipped directory:

> PS
> C:\\Users\\maheshp\\Downloads\\telepresencInstaller\\telepresence\\\>
> cd ../.. PS C:\\Users\\maheshp\\Downloads\>Remove-Item
> telepresenceInstaller -Recurse - Confirm:\$false -Force
>
> \# 5. Telepresence is now installed and you can use telepresence
> commands in PowerShell

Workflow 1: Using telepresence to develop code on the K8s cluster from your workstation
=======================================================================================

#### Before we proceed let\'s take a look at some pre-requisites

1.  Telepresence can be used to intercept the traffic from the following
    types of K8s workload

    1.  [Deployment]{.underline}

    2.  [ReplicaSet]{.underline}

    3.  [StatefulSet]{.underline}

2.  The Workload should have a [K8s service]{.underline} associated with
    it (ClusterIP, NodePort, LoadBalancer)

3.  The current context in your config file in the .kube folder should
    point to the K8s cluster where you want to use telepresence.

4.  If you want to avoid downtime of the microservice you are trying to
    intercept, then make sure the code of the microservice is running on
    the workstation

> In the following walkthrough, we will use an HTTP server written in
> Golang which serves an HTML static file.
>
> To set this up, download the source code as mentioned
> [here]{.underline} and navigate to iatcp-telepresence-
> maheshp-telepresence-examples-v1/example1/
>
> \[maheshp\@vdi-dd1bgl-022:\~/Desktop\] \...
>
> \$ ls
>
> iatcp-telepresence-maheshp-telepresence-examples-v1/
>
> \$ cd iatcp-telepresence-maheshp-telepresence-examples-v1/example1/

1.  **Steps to create the example1 one deployment on K8s cluster**

+-----+------------------------------+------------------------------+
| > 1 | > First, we will create the  | > \#Current directory        |
|     | > container image, navigate  | >                            |
|     | > to the example1-image      | > \$ pwd                     |
|     | > folder and build the       | >                            |
|     | > docker image (pointing to  | > /home/maheshp/D            |
|     | > the localhost registry)    | esktop/iatcp-telepresence-ma |
|     | > and load it to minikube    | heshp-telepresence-examples- |
|     |                              | > v1/example1                |
|     |                              | >                            |
|     |                              | > \#Navigate to              |
|     |                              | > example1-image             |
|     |                              | >                            |
|     |                              | > \$ cd example1-image/      |
|     |                              | >                            |
|     |                              | > \# Building the image      |
|     |                              | >                            |
|     |                              | > \$ docker build -t         |
|     |                              | > example1 .                 |
|     |                              | >                            |
|     |                              | > \#Load the image to        |
|     |                              | > minikube                   |
|     |                              | >                            |
|     |                              | > \$ minikube image load     |
|     |                              | > example1                   |
|     |                              | >                            |
|     |                              | > \#Navigate back to         |
|     |                              | > application directory      |
|     |                              | >                            |
|     |                              | > \$cd ..                    |
+=====+==============================+==============================+
| > 2 | > Create the deployment      | > \#Navigate to helm         |
|     | > using the \"my-            | > directory                  |
|     | > microservice\" helm chart  | >                            |
|     | > in the directory           | > \$ cd helm/                |
|     | > example1/helm/             | >                            |
|     |                              | > \$ pwd                     |
|     |                              | >                            |
|     |                              | > /home/maheshp/D            |
|     |                              | esktop/iatcp-telepresence-ma |
|     |                              | heshp-telepresence-examples- |
|     |                              | > v1/example1/helm           |
|     |                              | >                            |
|     |                              | > \#helm install \<name of   |
|     |                              | > release\>                  |
|     |                              | >                            |
|     |                              | > \$ helm install mahesh     |
|     |                              | > my-microservice            |
|     |                              | >                            |
|     |                              | > \#Navigate back to         |
|     |                              | > example1 folder            |
|     |                              | >                            |
|     |                              | > \$ cd ..                   |
|     |                              | >                            |
|     |                              | > \#Once the Deployments are |
|     |                              | > ready we can launch the    |
|     |                              | > service in browser with    |
|     |                              | > minikube service \<service |
|     |                              | > name\>                     |
|     |                              | >                            |
|     |                              | > \$ minikube service        |
|     |                              | > mahesh-my-microservice     |
+-----+------------------------------+------------------------------+

#### We can see that there is a hello message from

> 3 the K8s cluster is being served at the K8s node port.
>
> \#Once the Deployments are ready we can launch the service in browser
> with \"minikube service \<service name\>\"
>
> ![](media/image1.jpeg)\$ minikube service mahesh-my-microservice
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--
>
> \-\-\-\-\-\-\--\|
>
> \| NAMESPACE \| NAME \| TARGET PORT \| URL
>
> \|
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--
>
> \-\-\-\-\-\-\--\|
>
> \| default \| mahesh-my-microservice \| http/5000 \|
> http://192.168.49.2:30260 \|
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--
>
> \-\-\-\-\-\-\--\|
>
> 🎉 Opening service default/mahesh-my-microservice in default
> browser\...
>
> \#This will provide \<the Node-IP\>:\<Node-Port\> URL of the K8s
> cluster and launch the same in your default browser.

2.  Steps to run the example1 code on your workstation
    --------------------------------------------------

3.  ![](media/image2.jpeg)**Steps to use Telepresence for developing the
    > code live on the cluster**

![](media/image3.jpeg)

#### We can see that the request at the K8s cluster\'s end( 192.168.49.2:31814 which is

> 6 the minikube cluster IP) is
>
> being served by the code running on the workstation.

We can see that the request at the K8s cluster\'s end (192.168. which is
the minikube cluster IP) is being served by the code workstation.

You can check your K8s cluster ip on for minkube with below co

\$ minikube profile list

🎉 minikube 1.30.1 is available! Download it:
https://github.com/kubernetes/minikube/releases/tag/v1.30.1

💡 To disable this notice, run: \'minikube config set WantUpda false\'

\|\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\--\|\-\-\-\-\--

\-\-\-\-\--\|\-\-\-\-\-\-\--\|

\| Profile \| VM Driver \| Runtime \| IP \| Port \| Versi Nodes \|
Active \|

\|\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\--\|\-\-\-\-\--

\-\-\-\-\--\|\-\-\-\-\-\-\--\|

\| minikube \| docker \| docker \| 192.168.49.2 \| 8443 \| v1.23 1 \| \*
\|

\|\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\--\|\-\-\-\-\--

\-\-\-\-\--\|\-\-\-\-\-\-\--\|

\#OR

\#Once the Deployments are ready we can launch the service in \"minikube
service \<service name\>\"

\$ minikube service mahesh-my-microservice

\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\--

\--\|

\| NAMESPACE \| NAME \| TARGET PORT \|

\|

\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\--

\--\|

\| default \| mahesh-my-microservice \| http/5000 \|

![](media/image4.jpeg)

Workflow 2: Using telepresence to set up your local development workspace
=========================================================================

#### We will now see how users can use telepresence to extract env variables and volume mounts to mimic the K8s cluster.

> The example microservice serves as a static HTML page (in volume mount
> of the k8s deployment) that will display the value of the env variable
> defined inside the K8s cluster (at the container level).
>
> To set this up, download the source code as mentioned
> [here]{.underline} and navigate to iatcp-telepresence-
> maheshp-telepresence-examples-v1/example2/
>
> \[maheshp\@vdi-dd1bgl-022:\~/Desktop\] \...
>
> \$ ls
>
> iatcp-telepresence-maheshp-telepresence-examples-v1/
>
> \$ cd iatcp-telepresence-maheshp-telepresence-examples-v1/example2/

1.  **Steps to create the example2 deployment on K8s cluster**

#### u

> We can see that the home.html in the volume mount is now being served
> with environment variables at the K8s cluster level like
>
> 6 KUBERNETETETES\_SERVICE\_HOST AND KUBERNETETETES\_SERVICE\_PORT, at
> the K8s Cluster node port.
>
> \#Once the Deployments are ready we can launch the \"minikube service
> \<service name\>\"
>
> ![](media/image5.jpeg)\$ minikube service mahesh-my-microservice
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\--
>
> \--\|
>
> \| NAMESPACE \| NAME \| TARGET PORT
>
> \|
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\--
>
> \--\|
>
> \| default \| mahesh-my-microservice \| http/5000
> http://192.168.49.2:30260 \|
>
> \|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\--
>
> \--\|
>
> 🎉 Opening service default/mahesh-my-microservice
>
> \#This will provide \<the Node-IP\>:\<Node-Port\> URL o launch the
> same in your default browser.

Steps to use telepresence for setting up your local development workspace
-------------------------------------------------------------------------

> \#This will connect telepresence daemon on your workstation with telep
> traffic manager on the K8s cluster
>
> \$ telepresence connect
>
> Connected to context minikube (https://192.168.49.2:8443)
>
> \#This will list all the workloads we can intercept
>
> \$ telepresence list
>
> mahesh-my-microservicemy-microservice: ready to intercept (traffic-ag
> yet installed)
>
> \#Currently we are in application directory
>
> \$ pwd
>
> /home/\..../Telepresence-examples-main/example2/
>
> \#We will create a folder to store all the different volume mounts fro
> deployment
>
> \$ mkdir local\_volume\_mount

#### Connect telepresence to your K8s cluster, telepresence will use

> 2 the config file in the
>
> ./kube folder to identify the cluster to which it will connect.
>
> \#Run below command to intercept the miroservice
>
> \#\--port is the port on your workstation where all the traffic from t
> cluster will be \#routed to.
>
> \#\--env-file will create a .env file in the specified path and name
> wi the envoirment \#variables in \#at the container level.
>
> \#\--mount will copy all the volume mounts of worklaod to the path
> spec
>
> \$ telepresence intercept mahesh-my-microservice \--port 5000
> \--env-fil
>
> ./local.env \--mount ./local\_volume\_mount/ Using Deployment
> mahesh-my-microservice intercepted
>
> Intercept name : mahesh-my-microservice State : ACTIVE
>
> Workload kind : Deployment
>
> Destination : 127.0.0.1:5000 Service Port Identifier: http
>
> Volume Mount Point : /home/\..../Telepresence-examples-
> main/example2/local\_volume\_mount
>
> Intercepting : all TCP requests
>
> \#NOTE:Windows can only perform remote mounts using drives,and not fol
> hence we need to provide a Letter for \#drive(unused) followed by a co
>
> -mount=X:, Therefore for windows user the command will look like this
> PS C:\\Users\\maheshp\\Desktop\\example2\> telepresence intercept
> mahesh-m microservice \--port 5000 \--env-file=.\\local.env \--mount
> X:
>
> Using Deployment mahesh-my-microservice intercepted
>
> Intercept name : mahesh-my-microservice State : ACTIVE
>
> Workload kind : Deployment
>
> Destination : 127.0.0.1:5001 Service Port Identifier: http
>
> Volume Mount Point : X:
>
> Intercepting : all TCP requests

![](media/image6.jpeg)

#### n

![](media/image7.jpeg)

6.  **Workflow 3: Using telepresence to debug your code at the K8s
    cluster level**

> Suppose there was a code change after which the microservice is not
> working as expected. This might be due to several reasons such as
> wrong logic, issues with the efficiency or reliability of code, or
> issue w.r.t connectivity with other k8s resources. These issues can be
> solved faster if we can use the same debugging tools and procedures we
> do while developing the microservice locally, at the K8s cluster
> level(which is isolated ).
>
> Our example is a simple word count application that takes text as
> input and gives you an analysis of words, like the count of each word,
> and the total number of words.
>
> To set this up, download the source code as mentioned
> [here]{.underline} and navigate to iatcp-telepresence-
> maheshp-telepresence-examples-v1/example2/
>
> \[maheshp\@vdi-dd1bgl-022:\~/Desktop\] \...
>
> \$ ls
>
> iatcp-telepresence-maheshp-telepresence-examples-v1/
>
> \$ cd iatcp-telepresence-maheshp-telepresence-examples-v1/example3/

Steps to create the example3 one deployment on the K8s cluster
--------------------------------------------------------------

+-----+------------------------------+------------------------------+
|     | **Steps**                    | **Details**                  |
+=====+==============================+==============================+
| > 1 | > First, we will create the  | > \#Current directory        |
|     | > container image, for this  | >                            |
|     | > navigate to the            | > \$ pwd                     |
|     | > example3/example3-image    | >                            |
|     | > folder.                    | > /home/maheshp              |
|     | >                            | /Desktop/iatcp-telepresence- |
|     | > Build the docker image and | > maheshp-telep              |
|     | > load it to minikube        | resence-examples-v1/example3 |
|     |                              | >                            |
|     |                              | > \#Navigate to              |
|     |                              | > example3-image             |
|     |                              | >                            |
|     |                              | > \$ cd example3-image/      |
|     |                              | >                            |
|     |                              | > \# Building the image      |
|     |                              | >                            |
|     |                              | > \$ docker build -t         |
|     |                              | > example3 .                 |
|     |                              | >                            |
|     |                              | > \#Load the image to        |
|     |                              | > minikube                   |
|     |                              | >                            |
|     |                              | > \$ minikube image load     |
|     |                              | > example3                   |
|     |                              | >                            |
|     |                              | > \#Navigate back to         |
|     |                              | > application directory      |
|     |                              | >                            |
|     |                              | > \$ cd ..                   |
+-----+------------------------------+------------------------------+

+-----+------------------------------+------------------------------+
| > 2 | > Create the deployment      | > \#Navigate inside helm     |
|     | > using the                  | > directory                  |
|     | > \"my-microservice\" helm   | >                            |
|     | > chart in the example3/helm | > \$ cd helm/                |
|     | > folder                     | >                            |
|     |                              | > \$ pwd                     |
|     |                              | >                            |
|     |                              | > /home/maheshp              |
|     |                              | /Desktop/iatcp-telepresence- |
|     |                              | > maheshp-telepresen         |
|     |                              | ce-examples-v1/example3/helm |
|     |                              | >                            |
|     |                              | > \#helm install \<name of   |
|     |                              | > release\>                  |
|     |                              | >                            |
|     |                              | > \$ helm install mahesh     |
|     |                              | > my-microservice            |
|     |                              | >                            |
|     |                              | > \#Navigate back to         |
|     |                              | > application directory      |
|     |                              | >                            |
|     |                              | > \$ cd ..                   |
+=====+==============================+==============================+
| > 3 | > We can see that the word   | > \#Once the Deployments are |
|     | > counter                    | > ready we can launch        |
+-----+------------------------------+------------------------------+
|     |                              | > the service in browser     |
|     |                              | > with \"minikube service    |
+-----+------------------------------+------------------------------+
|     |                              | > \<service name\>\"         |
+-----+------------------------------+------------------------------+
|     |                              | > \$ minikube service        |
|     |                              | > mahesh-my-microservice     |
+-----+------------------------------+------------------------------+
|     |                              | > \|\-\                      |
|     |                              | -\-\-\-\-\-\-\-\--\|\-\-\-\- |
|     |                              | \-\-\-\-\-\-\-\-\-\-\-\-\-\- |
|     |                              | \-\-\-\-\--\|\-\-\-\-\-\-\-- |
+-----+------------------------------+------------------------------+
|     |                              | > \-\-\-\--\                 |
|     |                              | |\-\-\-\-\-\-\-\-\-\-\-\-\-\ |
|     |                              | -\-\-\-\-\-\-\-\-\-\-\-\--\| |
+-----+------------------------------+------------------------------+
|     |                              | > \| NAMESPACE \| NAME \|    |
|     |                              | > TARGET                     |
+-----+------------------------------+------------------------------+
|     |                              | > PORT \| URL \|             |
+-----+------------------------------+------------------------------+
|     |                              | > \|\-\                      |
|     |                              | -\-\-\-\-\-\-\-\--\|\-\-\-\- |
|     |                              | \-\-\-\-\-\-\-\-\-\-\-\-\-\- |
|     |                              | \-\-\-\-\--\|\-\-\-\-\-\-\-- |
+-----+------------------------------+------------------------------+
|     |                              | > \-\-\-\--\                 |
|     |                              | |\-\-\-\-\-\-\-\-\-\-\-\-\-\ |
|     |                              | -\-\-\-\-\-\-\-\-\-\-\-\--\| |
+-----+------------------------------+------------------------------+
|     |                              | > \| default \|              |
|     |                              | > mahesh-my-microservice \|  |
+-----+------------------------------+------------------------------+
|     |                              | > http/5000 \|               |
|     |                              | > http://192.168.49.2:30260  |
|     |                              | > \|                         |
+-----+------------------------------+------------------------------+
|     |                              | > \|\-\                      |
|     |                              | -\-\-\-\-\-\-\-\--\|\-\-\-\- |
|     |                              | \-\-\-\-\-\-\-\-\-\-\-\-\-\- |
|     |                              | \-\-\-\-\--\|\-\-\-\-\-\-\-- |
+-----+------------------------------+------------------------------+
|     |                              | > \-\-\-\--\                 |
|     |                              | |\-\-\-\-\-\-\-\-\-\-\-\-\-\ |
|     |                              | -\-\-\-\-\-\-\-\-\-\-\-\--\| |
+-----+------------------------------+------------------------------+
|     |                              | > 🎉 Opening service          |
|     |                              | > default/mahesh-my-         |
+-----+------------------------------+------------------------------+
|     |                              | > microservice in default    |
|     |                              | > browser\...                |
+-----+------------------------------+------------------------------+
|     |                              | > \#This will provide \<the  |
|     |                              | > Node-IP\>:\<Node-Port\>    |
+-----+------------------------------+------------------------------+
|     |                              | > URL and launch the same in |
|     |                              | > your default               |
+-----+------------------------------+------------------------------+
|     |                              | > browser.                   |
|     |                              | >                            |
|     |                              | > ![](media/image8.jpeg){    |
|     |                              | width="2.7895395888013996in" |
|     |                              | > he                         |
|     |                              | ight="1.0865616797900262in"} |
|     |                              | >                            |
|     |                              | > ![](media/image9.jpeg)     |
|     |                              | {width="2.768075240594926in" |
|     |                              | > he                         |
|     |                              | ight="0.9848950131233596in"} |
+-----+------------------------------+------------------------------+
|     | > project is now being       |                              |
|     | > served by the              |                              |
+-----+------------------------------+------------------------------+
|     | > K8s cluster at the         |                              |
|     | > [NodePort]{.underline}     |                              |
+-----+------------------------------+------------------------------+

2.  **Steps to run the example3 code on your workstation**

+-----+------------------------------+------------------------------+
|     | **Steps**                    | **Details**                  |
+=====+==============================+==============================+
| > 1 | > Now to run the code        |                              |
|     | > locally make sure you have |                              |
|     | > golang installed, you can  |                              |
|     | > do it from                 |                              |
|     | > [here]{.underline}         |                              |
+-----+------------------------------+------------------------------+
| > 2 | > Navigate to                | > \#Current directory        |
|     | > example3/main.go file and  | >                            |
|     | > run the main.go file.      | > \$ pwd                     |
|     |                              | >                            |
|     |                              | > /home/                     |
|     |                              | maheshp/Desktop/iatcp-telepr |
|     |                              | esence-maheshp-telepresence- |
|     |                              | > examples-v1/example3       |
|     |                              | >                            |
|     |                              | > \$ ls                      |
|     |                              | >                            |
|     |                              | > example3-image/ go.mod     |
|     |                              | > helm/ main.go              |
|     |                              | > readme-example3            |
|     |                              | >                            |
|     |                              | > \# Run the golang http     |
|     |                              | > server go run main.go      |
+-----+------------------------------+------------------------------+
| > 4 | > The index.html page in the | > ![](media/image10.jpeg)    |
|     | > static folder in the       | {width="5.279482720909886in" |
|     | > application directory will | > he                         |
|     | > now be served at the       | ight="2.5404166666666668in"} |
|     | > workstation port 5000 (i.e |                              |
|     | >                            |                              |
|     | > http://localhost:5000)     |                              |
+-----+------------------------------+------------------------------+

3.  **Steps to use telepresence to debug your code at the K8s cluster
    > level**

### Steps Details

> ![](media/image11.jpeg)

![](media/image13.jpeg)![](media/image14.jpeg)![](media/image15.jpeg)

7.  **Workflow 4: Using telepresence for automated testing of
    cloud-native code**

#### Users can utilize the fact that all the endpoints within the K8s cluster are made available to the workstation once telepresence is connected to the K8s cluster. They can create scripts for automation/testing and also use tools like Postman, curl, netcat, nslookup on your workstation to test the microservice and the entire architecture from within the K8s cluster.

> Let\'s consider an example where there are 2 versions of microservices
> that provide some processed data from their API endpoints which will
> be further used by the rest of the application workflow and you want
> to test this microservice live and compare the data returned by both
> the services.
>
> To set this up, download the source code as mentioned
> [here]{.underline} and navigate to iatcp-telepresence-
> maheshp-telepresence-examples-v1/example2/
>
> \[maheshp\@vdi-dd1bgl-022:\~/Desktop\] \...
>
> \$ ls
>
> ![](media/image16.jpeg)![](media/image17.png)![](media/image18.png)iatcp-telepresence-maheshp-telepresence-examples-v1/
>
> \$ cd iatcp-telepresence-maheshp-telepresence-examples-v1/example4/

1.  **Steps to create the example4 deployment on K8s cluster**

2.  **Steps to create a script to test the K8s workloads with
    > telepresence**

**Steps Details**

> Once the
>
> \#These are the k8 services of the miroservices app1 and app2
>
> \$ kubectl get svc

#### microservices are

> NAME TYPE CLUSTER-IP EXTERNAL-IP PORT
>
> app1-my-mircoservice ClusterIP 10.107.194.180 \<none\> 5000/

#### deployed to the

> app2-my-mircoservice ClusterIP 10.100.187.151 \<none\> 5001/

#### K8s cluster the

> resources and endpoints of the microservice are
>
> \$ nc -zv app1-my-microservice.default 8080

#### isolated to the K8s

1.  network and are not accessible directly.

> We can see that when we try to *curl* or perform *nslookup* the
> internal service urls
>
> Connect

2.  telepresence to your K8s cluster

> Once telepresence is connected to your K8s cluster your workstation
> behaves as part of the K8s internal

3.  network and hence all the resources

> are now accessible.
>
> nc: getaddrinfo for host \"app1-my-microservice.default\" port 8080:
> Name service not known
>
> \$ curl http://app1-my-microservice.default:8080/users
>
> curl: (6) Could not resolve host: app1-my-microservice.default
>
> \$ nslookup app1-my-microservice.default Server: 172.18.74.9
>
> Address: 172.18.74.9\#53
>
> \*\* server can\'t find app1-my-microservice.default: NXDOMAIN
>
> \$ telepresence connect
>
> Connected to context minikube (https://192.168.49.2:8443)
>
> \$ nslookup app1-my-microservice.default Server: 172.18.74.9
>
> Address: 172.18.74.9\#53
>
> Name: app1-my-microservice.default Address: 10.104.129.106
>
> \$ curl http://app1-my-microservice.default:8080/users
> \[{\"name\":\"Alice\",\"age\":23},{\"name\":\"Bob\",\"age\":30},{\"name\":\"Charlie\",\"a

#### we can see that all the commands that previously failed now succeed

> \$ nc -zv app1-my-microservice.default 8080
>
> Connection to app1-my-microservice.default (10.104.129.106) 8080 port
> alt\] succeeded!

![](media/image19.jpeg)-

#### Here we can see that the script creates GET

> \#Below code snippet is from the main.go script in the previous step.
>
> \#We can see that the code executes a get request to the API endpoint
> wh only accesible from within the K8s cluster

#### requests to each microservice and

6.  then compares the responses and prints a relevant message if there
    is

> resp, err :=
> http.Get(\"http://app1-my-microservice.default:8080/users\")
>
> if err != nil {
>
> fmt.Println(\"Error: \", err) return
>
> }
>
> defer resp.Body.Close()
>
> resp1, err :=
> http.Get(\"http://app2-my-microservice.default:8081/users\"

#### a deviation in the

> response
>
> **Similarly, developers can use any tool or language they**

7.  **prefer to interact with the**

> **microservices and automate tests inside the K8s cluster**
>
> Once you are done working, you can

8.  terminate the telepresence

> connection to the K8s cluster
>
> To clean up the K8s cluster we can use Helm to uninstall the
> deployment
>
> if err != nil {
>
> fmt.Println(\"Error: \", err) return
>
> }
>
> defer resp1.Body.Close()
>
> \#Run the below command to disconnect telepresence
>
> \$ telepresence quit
>
> Telepresence Daemons disconnecting\...done
>
> \$ helm uninstall app1 release \"app1\" uninstalled
>
> \$ helm uninstall app2 release \"app2\" uninstalled
