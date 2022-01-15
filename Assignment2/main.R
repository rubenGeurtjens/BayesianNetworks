#Import libraries
library(dagitty)
library(bnlearn)
library(igraph)
library(testit)
library(SID)

#Create data compatible with structure learning algorithms
data_dis <- read.csv('discretized_dataset.csv')
data_dis <- subset (data_dis, select = c(-X, -index))
data_dis_factor <- lapply(data_dis, as.factor)
data_dis <- data.frame(data_dis_factor)

#Helper functions used below

#Create adjmatrix from dagitty object
dagitty_to_adjmatrix <- function(daggity_obj) {
  edg <- dagitty:::edges(daggity_obj)
  node_names <- dagitty:::names.dagitty(daggity_obj)
  ans_mat <- matrix(
    data = 0, nrow = length(node_names),
    ncol = length(node_names),
    dimnames = list(node_names, node_names)
  )
  ans_mat[as.matrix(edg[c("v", "w")])] <- 1
  return(ans_mat)
}

#BNlearn object to adjmatrix
bn_to_adjmatrix <- function(bn_obj) {
  edg <- as.data.frame(bn_obj$arcs)
  node_names <- names(bn_obj$nodes)
  ans_mat <- matrix(
    data = 0, nrow = length(node_names),
    ncol = length(node_names),
    dimnames = list(node_names, node_names)
  )
  
  ans_mat[as.matrix(edg[c("from", "to")])] <- 1
  return(ans_mat)
}

#Makes adjmatrix from daggity object with column and row order of specified data
dagitty_to_adjmatrix_order <- function(Dag, data){
  adjmatrix <- dagitty_to_adjmatrix(Dag)
  org_network <- empty.graph(colnames(data))
  amat(org_network) <- adjmatrix
  adjmatrix_org <- bn_to_adjmatrix(org_network)
}

#Convert adjmatrix to dagitty object
adjmatrix_to_dagitty <- function(adjmatrix) {
  if (is.null(rownames(adjmatrix)) | is.null(colnames(adjmatrix)) | !identical(rownames(adjmatrix), colnames(adjmatrix))) {
    warning("Matrix column names or rownames are either missing or not compatible. They will be replaced by numeric node names")
    nodes <- 1:nrow(adjmatrix)
  } else {
    nodes <- rownames(adjmatrix)
  }
  
  from_to <- which(adjmatrix == 1, arr.ind = T)
  
  dag_string <- paste0(
    "dag { \n",
    paste0(nodes, collapse = "\n"),
    "\n",
    paste0(apply(from_to, 1, function(x) paste0(nodes[x[1]], " -> ", nodes[x[2]])),
           collapse = "\n"
    ),
    "\n } \n"
  )
  return(dagitty:::dagitty(dag_string))
}

#Calculates the confustion matrix based on the skeletons of both adjmatricesa 
confmatrix_skeleton <- function(adjmatrix_pred, adjmatrix_target){
  assert("Matrices must be square", {(nrow(adjmatrix_pred)==ncol(adjmatrix_pred)) &
      (nrow(adjmatrix_target)==ncol(adjmatrix_target))})
  tp <- 0
  tn <- 0
  fp <- 0
  fn <- 0
  for (r in 1:nrow(adjmatrix_target)){   
    for (c in 1:ncol(adjmatrix_target)){
      target <- adjmatrix_target[r,c] == 1 | adjmatrix_target[c,r] == 1
      pred <- adjmatrix_pred[r,c] == 1 | adjmatrix_pred[c,r] == 1
      #True negative cases
      if(!target & !pred){
        tn <- tn + 1
      }
      #True positive cases
      if(target & pred){
        tp <- tp + 1
      }
      #False negative cases
      if(target & !pred){
        fn <- fn + 1
      }
      #False positive cases
      if(!target & pred){
        fp <- fp + 1
      }
    }
  }
  #Remove cycles from true negative cases
  tn <- tn - ncol(adjmatrix_target)
  #Divide by 2 since every edge is counted twice in the loop
  tn <- tn / 2
  fn <- fn / 2
  tp <- tp / 2
  fp <- fp / 2
  metrics <- list("TPs" = tp, "FPs" = fp, "TNs" = tn, "FNs" = fn)
  return(metrics)
}

confmatrix_dag <- function(adjmatrix_pred, adjmatrix_target){
  assert("Matrices must be square", {(nrow(adjmatrix_pred)==ncol(adjmatrix_pred)) &
      (nrow(adjmatrix_target)==ncol(adjmatrix_target))})
  tp <- 0
  tn <- 0
  fp <- 0
  fn <- 0
  for (r in 1:nrow(adjmatrix_target)){   
    for (c in 1:ncol(adjmatrix_target)){
      #True negative cases
      if(adjmatrix_target[r,c]== 0 & adjmatrix_pred[r,c] == 0){
        tn <- tn + 1
      }
      #True positive cases
      if(adjmatrix_target[r,c] == 1 & adjmatrix_pred[r,c] == 1){
        tp <- tp + 1
      }
      #False negative cases
      if(adjmatrix_target[r,c] == 1 & adjmatrix_pred[r,c] == 0){
        fn <- fn + 1
      }
      #False positive cases
      if(adjmatrix_target[r,c] == 0 & adjmatrix_pred[r,c] == 1){
        fp <- fp + 1
      }
    }
  }
  #Remove cycles from true negative cases
  tn <- tn - ncol(adjmatrix_target)
  metrics <- list("TP" = tp, "FP" = fp, "TN" = tn, "FN" = fn)
  return(metrics)
}

#Dagitty object of our Dag in assignment 1
ass1Dag <- dagitty('dag {
  age [pos="-1.202,-1.302"]
  sex [pos="-1.344,0.153"]
  cp [pos="-0.287,-1.521"]
  trestbps [pos="-1.053,1.290"]
  chol [pos="-1.686,1.303"]
  fbs [pos="-0.610,-1.310"]
  restecg [pos="-0.622,0.145"]
  thalach [pos="0.281,1.326"]
  exang [pos="0.148,0.149"]
  oldpeak [pos="0.215,-0.548"]
  slope [pos="-0.408,1.317"]
  ca [pos="-1.074,-0.515"]
  thal [pos="-1.698,-0.605"]
  hd [pos="-0.790,-0.840"]
  age -> ca
  age -> fbs
  age -> hd
  age -> thalach [pos="-1.612,-1.148"]
  age -> trestbps
  chol -> hd [beta="0.1"]
  cp -> exang
  exang -> thalach [pos="-1.763,0.454"]
  hd -> ca
  hd -> cp
  hd -> exang
  hd -> oldpeak
  hd -> restecg
  hd -> slope
  oldpeak -> slope
  sex -> chol
  sex -> thal
  thal -> hd
  thal -> thalach
  trestbps -> hd
}')

#This function runs the SIHPC algorithm with all our alpha values, and returns the evaluation metrics
run_sihpc_variants <- function(alphas, data, adjmatrix_target_cpdag, adjmatrix_target_dag) {
  #Intialize lists to store evaluation metrics
  shds <- vector(mode='list', length=length(alphas))
  sids_lower <- vector(mode='list', length=length(alphas))
  sids_upper <- vector(mode='list', length=length(alphas))
  nredges <- vector(mode='list', length=length(alphas))
  betweenness_s <- vector(mode='list', length=length(alphas))
  #Skelotons
  TP_skels <- vector(mode='list', length=length(alphas))
  FP_skels <- vector(mode='list', length=length(alphas))
  TN_skels <- vector(mode='list', length=length(alphas))
  FN_skels <- vector(mode='list', length=length(alphas))
  TPR_skels <- vector(mode='list', length=length(alphas))
  FPR_skels <- vector(mode='list', length=length(alphas))
  F1_skels <- vector(mode='list', length=length(alphas))
  precision_skels <- vector(mode='list', length=length(alphas))
  recall_skels <- vector(mode='list', length=length(alphas))
  #Non-skelotons  
  TPs <- vector(mode='list', length=length(alphas))
  FPs <- vector(mode='list', length=length(alphas))
  TNs <- vector(mode='list', length=length(alphas))
  FNs <- vector(mode='list', length=length(alphas))
  TPRs <- vector(mode='list', length=length(alphas))
  FPRs <- vector(mode='list', length=length(alphas))
  F1s <- vector(mode='list', length=length(alphas))
  precisions <- vector(mode='list', length=length(alphas))
  recalls <- vector(mode='list', length=length(alphas))

  i <- 1
  for (alpha in alphas){
    print(paste(alpha))
    #Run algorithm, and convert output to cpdag
    sihpc <- si.hiton.pc(data, alpha = alpha)
    sihpc <- cpdag(sihpc)
    
    #Create bnlearn object from adjmatrix_target, necessary for some evaluation functions
    bn_target <- empty.graph(colnames(data))
    amat(bn_target) <- adjmatrix_target_cpdag
    
    shd <- bnlearn::shd(sihpc, bn_target)
    sid <- structIntervDist(adjmatrix_target_dag, bn_to_adjmatrix(sihpc))
    nredge <- narcs(sihpc)
    
    betweenness <- betweenness(as.igraph(sihpc))
    print("Betweenness centrality: ")
    print(paste(betweenness))
    
    metrics_skel <- confmatrix_skeleton(bn_to_adjmatrix(sihpc), adjmatrix_target_cpdag)
    metrics <- confmatrix_dag(bn_to_adjmatrix(sihpc), adjmatrix_target_cpdag)
    
    #Skeleton
    TP_skel <- metrics_skel$TPs
    FP_skel <- metrics_skel$FPs
    TN_skel <- metrics_skel$TNs
    FN_skel <- metrics_skel$FNs
    TPR_skel <- TP_skel / (TP_skel + FN_skel)
    FPR_skel <- FP_skel / (FP_skel + TN_skel)
    precision_skel <- TP_skel / (TP_skel + FP_skel)
    recall_skel <- TP_skel / (TP_skel + FN_skel)
    F1_skel <- 2*TP_skel/(2*TP_skel+FP_skel+FN_skel)
    
    #Non-skeleton
    TP <- metrics$TP
    FP <- metrics$FP
    TN <- metrics$TN
    FN <- metrics$FN
    TPR <- TP / (TP + FN)
    FPR <- FP / (FP + TN)
    precision <- TP / (TP + FP)
    recall <- TP / (TP + FN)
    F1 <- 2*TP/(2*TP +FP +FN)
    
    TP_skels[i] <- TP_skel
    FP_skels[i] <- FP_skel
    TN_skels[i] <- TN_skel
    FN_skels[i] <- FN_skel
    precision_skels[i] <- precision_skel
    recall_skels[i] <- recall_skel
    F1_skels[i] <- F1_skel
    TPR_skels[i] <- TPR_skel
    FPR_skels[i] <- FPR_skel
    
    TPs[i] <- TP
    FPs[i] <- FP
    TNs[i] <- TN
    FNs[i] <- FN
    precisions[i] <- precision
    recalls[i] <- recall
    F1s[i] <- F1
    TPRs[i] <- TPR
    FPRs[i] <- FPR
    
    
    shds[i] <- shd
    sids_lower[i] <- sid$sidLowerBound
    sids_upper[i] <- sid$sidUpperBound
    nredges[i] <- nredge
    i <- i + 1
  }
  print("alphas")
  print(paste(alphas))
  print("F1")
  print(paste(F1s))
  print("TP")
  print(paste(TPs))
  print("FP")
  print(paste(FPs))
  print("TN")
  print(paste(TNs))
  print("FN")
  print(paste(FNs))
  print("TPR")
  print(paste(TPRs))
  print("FPR")
  print(paste(FPRs))
  print("Precision")
  print(paste(precisions))
  print("Recall")
  print(paste(recalls))
  print("F1(skel)")
  print(paste(F1_skels))
  print("TP(skel)")
  print(paste(TP_skels))
  print("FP(skel)")
  print(paste(FP_skels))
  print("TN(skel)")
  print(paste(TN_skels))
  print("FN(skel)")
  print(paste(FN_skels))
  print("TPR(skel)")
  print(paste(TPR_skels))
  print("FPR(skel)")
  print(paste(FPR_skels))
  print("Precision(Skel)")
  print(paste(precision_skels))
  print("Recall(Skel)")
  print(paste(recall_skels))
  print("SHDs")
  print(paste(shds))
  print("SIDs_lower")
  print(paste(sids_lower))
  print("SIDs_upper")
  print(paste(sids_upper))
  print("Number of edges: ")
  print(paste(nredges))
}

run_hc_variants <- function(scores, data, adjmatrix_target_cpdag, adjmatrix_target_dag) {
  shds <- vector(mode='list', length=length(scores))
  sids_lower <- vector(mode='list', length=length(scores))
  sids_upper <- vector(mode='list', length=length(scores))
  nredges <- vector(mode='list', length=length(scores))
  #Skelotons
  TP_skels <- vector(mode='list', length=length(scores))
  FP_skels <- vector(mode='list', length=length(scores))
  TN_skels <- vector(mode='list', length=length(scores))
  FN_skels <- vector(mode='list', length=length(scores))
  TPR_skels <- vector(mode='list', length=length(scores))
  FPR_skels <- vector(mode='list', length=length(scores))
  F1_skels <- vector(mode='list', length=length(scores))
  precision_skels <- vector(mode='list', length=length(scores))
  recall_skels <- vector(mode='list', length=length(scores))
  #Non-skelotons  
  TPs <- vector(mode='list', length=length(scores))
  FPs <- vector(mode='list', length=length(scores))
  TNs <- vector(mode='list', length=length(scores))
  FNs <- vector(mode='list', length=length(scores))
  TPRs <- vector(mode='list', length=length(scores))
  FPRs <- vector(mode='list', length=length(scores))
  F1s <- vector(mode='list', length=length(scores))
  precisions <- vector(mode='list', length=length(scores))
  recalls <- vector(mode='list', length=length(scores))
  
  i <- 1
  for (score in scores){
    print(paste(score))
    #Run algorithm, and convert output to cpdag
    hc <- hc(data, score = score)
    hc <- cpdag(hc)
    
    #Create bnlearn object from adjmatrix_target, necessary for some evaluation functions
    bn_target <- empty.graph(colnames(data))
    amat(bn_target) <- adjmatrix_target_cpdag
    
    shd <- bnlearn::shd(hc, bn_target)
    sid <- structIntervDist(adjmatrix_target_dag, bn_to_adjmatrix(hc))
    nredge <- narcs(hc)
    betweenness <- betweenness(as.igraph(hc))
    print("Betweenness centrality: ")
    print(paste(betweenness))
    
    metrics_skel <- confmatrix_skeleton(bn_to_adjmatrix(hc), adjmatrix_target_cpdag)
    metrics <- confmatrix_dag(bn_to_adjmatrix(hc), adjmatrix_target_cpdag)
    
    #Skeleton
    TP_skel <- metrics_skel$TPs
    FP_skel <- metrics_skel$FPs
    TN_skel <- metrics_skel$TNs
    FN_skel <- metrics_skel$FNs
    TPR_skel <- TP_skel / (TP_skel + FN_skel)
    FPR_skel <- FP_skel / (FP_skel + TN_skel)
    precision_skel <- TP_skel / (TP_skel + FP_skel)
    recall_skel <- TP_skel / (TP_skel + FN_skel)
    F1_skel <- 2*TP_skel/(2*TP_skel+FP_skel+FN_skel)
    
    #Non-skeleton
    TP <- metrics$TP
    FP <- metrics$FP
    TN <- metrics$TN
    FN <- metrics$FN
    TPR <- TP / (TP + FN)
    FPR <- FP / (FP + TN)
    precision <- TP / (TP + FP)
    recall <- TP / (TP + FN)
    F1 <- 2*TP/(2*TP +FP +FN)
    
    TP_skels[i] <- TP_skel
    FP_skels[i] <- FP_skel
    TN_skels[i] <- TN_skel
    FN_skels[i] <- FN_skel
    precision_skels[i] <- precision_skel
    recall_skels[i] <- recall_skel
    F1_skels[i] <- F1_skel
    TPR_skels[i] <- TPR_skel
    FPR_skels[i] <- FPR_skel
    
    TPs[i] <- TP
    FPs[i] <- FP
    TNs[i] <- TN
    FNs[i] <- FN
    precisions[i] <- precision
    recalls[i] <- recall
    F1s[i] <- F1
    TPRs[i] <- TPR
    FPRs[i] <- FPR
    
    
    shds[i] <- shd
    sids_lower[i] <- sid$sidLowerBound
    sids_upper[i] <- sid$sidUpperBound
    nredges[i] <- nredge
    i <- i + 1
  }
  print("alphas")
  print(paste(scores))
  print("F1")
  print(paste(F1s))
  print("TP")
  print(paste(TPs))
  print("FP")
  print(paste(FPs))
  print("TN")
  print(paste(TNs))
  print("FN")
  print(paste(FNs))
  print("TPR")
  print(paste(TPRs))
  print("FPR")
  print(paste(FPRs))
  print("Precision")
  print(paste(precisions))
  print("Recall")
  print(paste(recalls))
  print("F1(skel)")
  print(paste(F1_skels))
  print("TP(skel)")
  print(paste(TP_skels))
  print("FP(skel)")
  print(paste(FP_skels))
  print("TN(skel)")
  print(paste(TN_skels))
  print("FN(skel)")
  print(paste(FN_skels))
  print("TPR(skel)")
  print(paste(TPR_skels))
  print("FPR(skel)")
  print(paste(FPR_skels))
  print("Precision(Skel)")
  print(paste(precision_skels))
  print("Recall(Skel)")
  print(paste(recall_skels))
  print("SHDs")
  print(paste(shds))
  print("SIDs_lower")
  print(paste(sids_lower))
  print("SIDs_upper")
  print(paste(sids_upper))
  print("Number of edges: ")
  print(paste(nredges))
}

#Obtain adjacency matrices of network used in assignment 1
dagittyadjmatrix <- dagitty_to_adjmatrix(ass1Dag)
bn_org <- empty.graph(colnames(data_dis))
amat(bn_org) <- dagittyadjmatrix
adjmatrix_target_cpdag <- bn_to_adjmatrix(cpdag(bn_org))
adjmatrix_target_dag <- bn_to_adjmatrix(bn_org)

#Define alphas, and scores
alphas = c(0.0001, 0.001, 0.01, 0.05, 0.1)
scores = c("aic", "bde", "bic", "qnml")

#Run variants
run_sihpc_variants(alphas, data_dis, adjmatrix_target_cpdag, adjmatrix_target_dag)
run_hc_variants(scores, data_dis, adjmatrix_target_cpdag, adjmatrix_target_dag)
