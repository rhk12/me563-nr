c------------------------------------------------------
      program truss
c------------------------------------------------------
c
c     Newton-Raphson solver for 1 D.O.F. truss example
c
c     Input:
c
c     d     ---> horizontal span
c     x     ---> initial height
c     area  ---> initial area
c     e     ---> Young modulus
c     nincr ---> number of load increments
c     fincr ---> force increment
c     cnorm ---> residual force convergence norm
c     miter ---> maximum number of Newton-Raphson
c                iterations
c
c------------------------------------------------------
c
c
      implicit double precision (a-h,o-z)
      double precision l,lzero
       data d,    x,    area, e,    f,   resid
     &     /3.,   4.,   1.,   1,    0.,  0./
      data nincr ,fincr,   cnorm,   miter 
     &     /1,  .001,       1.e-8,     20/
c
c     initialize geometry data and stiffness
c
      lzero=sqrt(x**2+d**2)
      vol=area*lzero
      stiff=(area/lzero)*e*(x/lzero)*(x/lzero)
c     starts load increments
c

      open (unit = 2, file = "output.dat")
c      write(2,*)'VARIABLES = incrm niter rnorm x f stiff'
      do incrm=1,nincr
         f=f+fincr
         resid=resid-fincr

c    Newton-Raphson iteration
        rnorm=cnorm*2
        niter=0
        do while((rnorm.gt.cnorm).and.(niter.lt.miter))
        niter=niter+1
c     find geometry increment
           u=-resid/stiff
           x=x+u
           l=sqrt(x*x+d*d)
           area=vol/l
c      find stresses and residual forces
           stress=e*log(l/lzero)
           t=stress*area*x/l
           resid=t-f
           rnorm=abs(resid/f)
           print 100, incrm,niter,rnorm,x,f
c      find stiffness and check stability
           stiff=(area/l)*(e-2.*stress)*(x/l)*(x/l)
     &          +(stress*area/l)
           write (2,200) incrm,niter,rnorm,x,f,stiff
           if(abs(stiff).lt.1.e-20) then
              print *, ' near zero stiffness - stop'
              stop
           endif 
           enddo
          enddo
         stop
         close(2) 
 100     format(' increment=',i3,' iteration=',i3,
     &       ' residual=',E10.3,
     &        ' x=',E10.4,' f=',E10.4)
200     format(I10,I10,E20.8,E20.8,E20.8,E20.8)



      end
