## Workflow 3: Using telepresence to debug your code at the K8s cluster level
Suppose there was a code change after which the microservice is not working as expected. This might be due to several reasons such as wrong logic, issues with the efficiency or reliability of code, or issue w.r.t connectivity with other k8s resources. These issues can be solved faster if we can use the same debugging tools and procedures we do while developing the microservice locally, at the K8s cluster level(which is isolated ).

Our example is a simple word count application that takes text as input and gives you an analysis of words, like the count of each word, and the total number of words. 

To set this up, download the source code as mentioned here and navigate to iatcp-telepresence-maheshp-telepresence-examples-v1/example2/
```

[maheshp@vdi-dd1bgl-022:~/Desktop] ...
$ ls
iatcp-telepresence-maheshp-telepresence-examples-v1/
 
$ cd iatcp-telepresence-maheshp-telepresence-examples-v1/example3/
```

### Steps to create the example3 one deployment on the K8s cluster
| Id | Steps| Details|
| -- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1  | First, we will create the container image, for this navigate to the example3/example3-image folder.<br><br>Build the docker image and load it to minikube | <pre>#Current directory<br>$ pwd<br>/home/maheshp/Desktop/iatcp-telepresence-maheshp-telepresence-examples-v1/example3<br> <br>#Navigate to example3-image<br>$ cd example3-image/<br> <br># Building the image<br>$ docker build -t example3 .  <br> <br>#Load the image to minikube<br>$ minikube image load example3<br> <br>#Navigate back to application directory<br>$ cd ..<br></pre> |
| 2  | Create the deployment using the "my-microservice" helm chart in the example3/helm folder<br>| <pre>   <br>#Navigate inside helm directory<br>$ cd helm/<br> <br>$ pwd<br>/home/maheshp/Desktop/iatcp-telepresence-maheshp-telepresence-examples-v1/example3/helm<br> <br>#helm install <name of release><br>$ helm install mahesh my-microservice<br> <br> <br>#Navigate back to application directory<br>$ cd ..<br></pre>|
| 3  | We can see that the word counter project is now being served by the K8s cluster at the NodePort                                                           | <pre>   <br>#Once the Deployments are ready we can launch the service in browser with "minikube service <service name>"<br>$ minikube service mahesh-my-microservice<br>|-----------|------------------------|-------------|---------------------------|<br>| NAMESPACE |          NAME          | TARGET PORT |            URL            |<br>|-----------|------------------------|-------------|---------------------------|<br>| default   | mahesh-my-microservice | http/5000   | http://192.168.49.2:30260 |<br>|-----------|------------------------|-------------|---------------------------|<br>ðŸŽ‰  Opening service default/mahesh-my-microservice in default browser...<br> <br>#This will provide <the Node-IP>:<Node-Port> URL and launch the same in your default browser.<br></pre><br>![image1](images/workflow3/image1.png)<br>![image2](images/workflow3/image2.png) |
