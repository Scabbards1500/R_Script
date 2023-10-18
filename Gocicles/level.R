#此处看分到几级
ggo <- groupGO(gene     = entrez_id,
               OrgDb    = org.Mm.eg.db,
               ont      = "BP",
               level    = 5,
               readable = TRUE)
write.csv(ggo,"hepatocyte_go.csv")