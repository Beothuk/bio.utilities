
require(Rcpp)
require(BH)

sourceCpp( rebuild=TRUE, code='

// [[Rcpp::plugins("cpp11")]] // needed? 
// [[Rcpp::depends(BH)]]

#include <Rcpp.h>
#include <boost/graph/astar_search.hpp>

#using namespace boost::graph;
#using namespace boost::graph;
#using namespace boost::graph;
#using namespace Rcpp;

//[[Rcpp::export]]

List  ( int nobs, double scale ) {
  // Rcpp:rexp uses scale (1/lambda) rather than rate (lambda) 
  // leave it this way for ssa as then there are fewer divisions
  RNGScope scope ;
  NumericVector rnddevs ; 
  rnddevs = rexp( nobs, scale ) ; 


  res = astar_search
      (g, start,
       distance_heuristic<mygraph_t, cost, location*>
        (locations, goal),
       predecessor_map(&p[0]).distance_map(&d[0]).
       visitor(astar_goal_visitor<vertex>(goal)));
  
  return( path );
}')


