function [A,B] = QuadrotorStateJacobianFcn(in1,in2)
%QuadrotorStateJacobianFcn
%    [A,B] = QuadrotorStateJacobianFcn(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    15-Mar-2024 22:47:45

phi_t = in1(4,:);
phi_dot_t = in1(10,:);
psi_t = in1(6,:);
psi_dot_t = in1(12,:);
theta_t = in1(5,:);
theta_dot_t = in1(11,:);
u1 = in2(1,:);
u2 = in2(2,:);
u3 = in2(3,:);
u4 = in2(4,:);
u5 = in2(5,:);
u6 = in2(6,:);
u7 = in2(7,:);
x_dot_t = in1(7,:);
y_dot_t = in1(8,:);
z_dot_t = in1(9,:);
t2 = conj(phi_t);
t3 = cos(phi_t);
t4 = conj(psi_t);
t5 = cos(psi_t);
t6 = conj(theta_t);
t7 = cos(theta_t);
t8 = sin(phi_t);
t9 = sin(psi_t);
t10 = sin(theta_t);
t17 = phi_t.*2.0;
t18 = psi_dot_t.^2;
t19 = theta_t.*2.0;
t20 = theta_dot_t.^2;
t30 = -x_dot_t;
t31 = -y_dot_t;
t32 = -z_dot_t;
t33 = u1+u2+u3+u4;
t11 = cos(t2);
t12 = cos(t4);
t13 = cos(t6);
t14 = sin(t2);
t15 = sin(t4);
t16 = sin(t6);
t21 = cos(t17);
t22 = t3.^2;
t23 = cos(t19);
t24 = t7.^2;
t25 = t7.^3;
t26 = sin(t17);
t27 = t8.^2;
t28 = sin(t19);
t29 = t10.^2;
t34 = t7.*6.0e+1;
t35 = 1.0./t7;
t38 = t10.*9.2e+1;
t39 = t10.*1.15e+2;
t40 = t30+u5;
t41 = t31+u6;
t42 = t32+u7;
t51 = (t3.*t5)./2.0;
t52 = (t3.*t9)./2.0;
t53 = (t5.*t8)./2.0;
t54 = (t8.*t9)./2.0;
t60 = t3.*t7.*t8.*5.5e+1;
t61 = t3.*t8.*t10.*5.5e+1;
t83 = t3.*t9.*t10.*(-1.0./2.0);
t84 = t5.*t8.*t10.*(-1.0./2.0);
t85 = t3.*t7.*(2.0e+2./4.71e+2);
t86 = t5.*t8.*(2.0e+2./4.71e+2);
t87 = t8.*t9.*(2.0e+2./4.71e+2);
t106 = t3.*t5.*t10.*(2.0e+2./4.71e+2);
t107 = t3.*t9.*t10.*(2.0e+2./4.71e+2);
t36 = 1.0./t24;
t37 = 1.0./t25;
t43 = -t38;
t44 = t22.*4.4e+1;
t45 = t22.*5.5e+1;
t46 = t26.*2.2e+1;
t47 = t11.*t12;
t48 = t11.*t15;
t49 = t12.*t14;
t50 = t14.*t15;
t62 = t10.*t54;
t67 = t13.*t42;
t68 = t16.*t42;
t69 = t10.*t22.*-4.4e+1;
t70 = t10.*t22.*-5.5e+1;
t73 = t10.*t51;
t79 = t10.*t60;
t80 = t7.*t22.*theta_dot_t.*5.06e+2;
t81 = t7.*t22.*u3.*-5.5e+1;
t92 = -t86;
t93 = t12.*t13.*t40;
t94 = t12.*t13.*t41;
t96 = t12.*t16.*t40;
t97 = t13.*t15.*t40;
t98 = t13.*t15.*t41;
t101 = t15.*t16.*t41;
t105 = phi_dot_t.*psi_dot_t.*t22.*t24.*5.06e+2;
t108 = psi_dot_t.*t7.*t10.*t22.*theta_dot_t.*-5.06e+2;
t117 = t10.*t18.*t22.*t24.*5.06e+2;
t124 = t52+t84;
t125 = t53+t83;
t134 = t87+t106;
t55 = -t44;
t56 = -t45;
t57 = t7.*t45;
t58 = t10.*t44;
t59 = t10.*t45;
t63 = t16.*t47;
t64 = t16.*t48;
t65 = t16.*t49;
t66 = t16.*t50;
t78 = t24.*t45;
t82 = t70.*u4;
t90 = phi_dot_t.*t80;
t91 = -t68;
t95 = t11.*t67;
t100 = t14.*t67;
t103 = t10.*t80;
t109 = -t97;
t112 = -t105;
t113 = t13.*t40.*t47;
t114 = t13.*t40.*t49;
t115 = t13.*t41.*t48;
t116 = t13.*t41.*t50;
t120 = t51+t62;
t121 = t54+t73;
t135 = t92+t107;
t139 = t67+t96+t101;
t71 = t57.*u1;
t72 = t57.*u3;
t74 = t59.*u2;
t88 = -t64;
t89 = -t65;
t110 = t11.*t91;
t111 = t14.*t91;
t118 = t47+t66;
t119 = t50+t63;
t136 = t94+t109;
t140 = t91+t93+t98;
t122 = t48+t89;
t123 = t49+t88;
t126 = t40.*t118;
t127 = t40.*t119;
t128 = t41.*t118;
t129 = t41.*t119;
t141 = t140.^2;
t142 = t110+t113+t115;
t143 = t111+t114+t116;
t146 = t10.*t16.*t140.*1.404458598726115e-2;
t147 = t5.*t7.*t16.*t140.*1.404458598726115e-2;
t148 = t7.*t9.*t16.*t140.*1.404458598726115e-2;
t149 = t10.*t12.*t13.*t140.*1.404458598726115e-2;
t150 = t10.*t13.*t15.*t140.*1.404458598726115e-2;
t151 = t5.*t7.*t12.*t13.*t140.*1.404458598726115e-2;
t152 = t7.*t9.*t12.*t13.*t140.*1.404458598726115e-2;
t153 = t5.*t7.*t13.*t15.*t140.*1.404458598726115e-2;
t154 = t7.*t9.*t13.*t15.*t140.*1.404458598726115e-2;
t130 = t40.*t122;
t131 = t40.*t123;
t132 = t41.*t122;
t133 = t41.*t123;
t137 = -t130;
t138 = -t133;
t144 = t126+t132;
t145 = t129+t131;
t155 = t95+t127+t138;
t156 = t100+t128+t137;
t157 = t155.^2;
t158 = t156.^2;
t159 = t7.*t8.*t13.*t14.*t156.*1.404458598726115e-2;
t160 = t3.*t7.*t11.*t13.*t155.*3.969936305732484e-2;
t161 = t7.*t8.*t118.*t156.*1.404458598726115e-2;
t162 = t3.*t7.*t119.*t155.*3.969936305732484e-2;
t163 = t7.*t8.*t122.*t156.*1.404458598726115e-2;
t164 = t13.*t14.*t120.*t156.*2.808917197452229e-2;
t165 = t13.*t14.*t124.*t156.*2.808917197452229e-2;
t166 = t3.*t7.*t123.*t155.*3.969936305732484e-2;
t167 = t11.*t13.*t121.*t155.*7.939872611464968e-2;
t168 = t11.*t13.*t125.*t155.*7.939872611464968e-2;
t169 = t118.*t120.*t156.*2.808917197452229e-2;
t170 = t118.*t124.*t156.*2.808917197452229e-2;
t171 = t119.*t121.*t155.*7.939872611464968e-2;
t172 = t120.*t122.*t156.*2.808917197452229e-2;
t173 = t119.*t125.*t155.*7.939872611464968e-2;
t174 = t122.*t124.*t156.*2.808917197452229e-2;
t175 = t121.*t123.*t155.*7.939872611464968e-2;
t176 = t123.*t125.*t155.*7.939872611464968e-2;
et1 = (t36.*(t7.*u1.*-9.2e+1+t7.*u2.*9.2e+1-t7.*u3.*9.2e+1+t7.*u4.*9.2e+1+phi_dot_t.*t23.*theta_dot_t.*4.6e+1-psi_dot_t.*t10.*theta_dot_t.*1.058e+3-t7.*t22.*u2.*4.4e+1-t7.*t22.*u4.*4.4e+1+t7.*t44.*u1+t7.*t44.*u3+phi_dot_t.*t22.*t24.*theta_dot_t.*5.06e+2-phi_dot_t.*t22.*t29.*theta_dot_t.*5.06e+2+psi_dot_t.*t10.*t22.*theta_dot_t.*5.06e+2-t3.*t8.*t24.*u1.*5.5e+1+t3.*t8.*t24.*u3.*5.5e+1+t3.*t8.*t29.*u1.*5.5e+1+t7.*t10.*t22.*u2.*1.1e+2-t3.*t8.*t29.*u3.*5.5e+1-t7.*t10.*t22.*u4.*1.1e+2+phi_dot_t.*psi_dot_t.*t3.*t8.*t25.*5.06e+2+psi_dot_t.*t10.*t22.*t24.*theta_dot_t.*1.518e+3+t3.*t7.*t8.*t10.*t18.*1.012e+3-t3.*t7.*t8.*t10.*t20.*1.012e+3-phi_dot_t.*psi_dot_t.*t3.*t7.*t8.*t29.*1.012e+3))./5.52e+2;
et2 = (t10.*t37.*(u2.*-1.15e+2+u4.*1.15e+2+t10.*t90-t10.*u1.*9.2e+1-t10.*u3.*9.2e+1-t22.*u4.*5.5e+1+t38.*u2+t38.*u4+t45.*u2+t58.*u1+t58.*u3+t69.*u2+t69.*u4+t78.*u4+t79.*u3+phi_dot_t.*t28.*theta_dot_t.*2.3e+1+psi_dot_t.*t7.*theta_dot_t.*1.058e+3-t22.*t24.*u2.*5.5e+1-psi_dot_t.*t7.*t22.*theta_dot_t.*5.06e+2-psi_dot_t.*t22.*t25.*theta_dot_t.*5.06e+2-t3.*t8.*t18.*t24.*5.06e+2+t3.*t8.*t20.*t24.*5.06e+2-t3.*t7.*t8.*t10.*u1.*5.5e+1+phi_dot_t.*psi_dot_t.*t3.*t8.*t10.*t24.*5.06e+2))./2.76e+2;
et3 = t36.*(t7.*u2.*1.15e+2-t7.*u4.*1.15e+2+t57.*u4+t61.*u3+phi_dot_t.*t10.*theta_dot_t.*4.6e+1-psi_dot_t.*t23.*theta_dot_t.*1.058e+3-t7.*t22.*u2.*5.5e+1+phi_dot_t.*t10.*t22.*theta_dot_t.*5.06e+2+psi_dot_t.*t22.*t24.*theta_dot_t.*5.06e+2-psi_dot_t.*t22.*t29.*theta_dot_t.*5.06e+2+t3.*t8.*t18.*t25.*5.06e+2-t3.*t8.*t10.*u1.*5.5e+1-t3.*t7.*t8.*t18.*t29.*1.012e+3+phi_dot_t.*psi_dot_t.*t3.*t7.*t8.*t10.*1.012e+3).*(-1.0./5.52e+2);
et4 = (t10.*t37.*(t74+t82+t90+t108-u1.*9.2e+1+u2.*9.2e+1-u3.*9.2e+1+u4.*9.2e+1-t10.*u2.*1.15e+2-t22.*u2.*4.4e+1-t22.*u4.*4.4e+1+t39.*u4+t44.*u1+t44.*u3+t60.*u3+phi_dot_t.*t7.*theta_dot_t.*4.6e+1+psi_dot_t.*t28.*theta_dot_t.*5.29e+2-t3.*t7.*t8.*u1.*5.5e+1+phi_dot_t.*psi_dot_t.*t3.*t8.*t24.*5.06e+2-t3.*t8.*t10.*t18.*t24.*5.06e+2))./2.76e+2;
mt1 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t33.*(t3.*t9-t5.*t8.*t10).*(2.0e+2./4.71e+2)+t121.*t158.*1.404458598726115e-2+t124.*t157.*3.969936305732484e-2-t121.*t155.*t156.*7.939872611464968e-2-t124.*t155.*t156.*2.808917197452229e-2,t33.*(t3.*t5+t8.*t9.*t10).*(-2.0e+2./4.71e+2)-t120.*t157.*3.969936305732484e-2-t125.*t158.*1.404458598726115e-2+t120.*t155.*t156.*2.808917197452229e-2+t125.*t155.*t156.*7.939872611464968e-2];
mt2 = [t7.*t8.*t33.*(-2.0e+2./4.71e+2)+t3.*t7.*t158.*7.022292993630573e-3-t7.*t8.*t157.*1.984968152866242e-2-t3.*t7.*t155.*t156.*3.969936305732484e-2+t7.*t8.*t155.*t156.*1.404458598726115e-2];
mt3 = [(t36.*(t10.*t72+t10.*t105-t18.*t22.*t24.*5.06e+2+t20.*t22.*t24.*5.06e+2+t18.*t24.*t27.*5.06e+2-t20.*t24.*t27.*5.06e+2-t3.*t8.*u2.*1.1e+2+t3.*t8.*u4.*1.1e+2+t7.*t70.*u1-t3.*t8.*t10.*u1.*8.8e+1+t3.*t8.*t10.*u2.*8.8e+1-t3.*t8.*t10.*u3.*8.8e+1+t3.*t8.*t10.*u4.*8.8e+1+t3.*t8.*t24.*u2.*1.1e+2-t3.*t8.*t24.*u4.*1.1e+2+t7.*t10.*t27.*u1.*5.5e+1-t7.*t10.*t27.*u3.*5.5e+1-phi_dot_t.*psi_dot_t.*t10.*t24.*t27.*5.06e+2+psi_dot_t.*t3.*t7.*t8.*theta_dot_t.*1.012e+3+psi_dot_t.*t3.*t8.*t25.*theta_dot_t.*1.012e+3-phi_dot_t.*t3.*t7.*t8.*t10.*theta_dot_t.*1.012e+3))./5.52e+2];
mt4 = [t35.*(t74+t82+t90+t108+t21.*u1.*4.4e+1-t21.*u2.*4.4e+1+t21.*u3.*4.4e+1-t21.*u4.*4.4e+1-t10.*t27.*u2.*5.5e+1+t10.*t27.*u4.*5.5e+1-phi_dot_t.*t7.*t27.*theta_dot_t.*5.06e+2-t3.*t7.*t8.*u1.*1.1e+2+t3.*t7.*t8.*u3.*1.1e+2+phi_dot_t.*psi_dot_t.*t3.*t8.*t24.*1.012e+3+psi_dot_t.*t7.*t10.*t27.*theta_dot_t.*5.06e+2-t3.*t8.*t10.*t18.*t24.*1.012e+3).*(-1.0./5.52e+2)];
mt5 = [t36.*(t71+t81+t112+t117+t3.*t8.*u1.*8.8e+1-t3.*t8.*u2.*8.8e+1+t3.*t8.*u3.*8.8e+1-t3.*t8.*u4.*8.8e+1-t7.*t27.*u1.*5.5e+1+t7.*t27.*u3.*5.5e+1+phi_dot_t.*psi_dot_t.*t24.*t27.*5.06e+2-t10.*t18.*t24.*t27.*5.06e+2+t3.*t8.*t10.*u2.*1.1e+2-t3.*t8.*t10.*u4.*1.1e+2+phi_dot_t.*t3.*t7.*t8.*theta_dot_t.*1.012e+3-psi_dot_t.*t3.*t7.*t8.*t10.*theta_dot_t.*1.012e+3).*(-1.0./5.52e+2),0.0,0.0,0.0,0.0,0.0,0.0];
mt6 = [t5.*t33.*t85-t5.*t10.*t141.*7.022292993630573e-3+t121.*t142.*t155.*7.939872611464968e-2-t124.*t143.*t156.*2.808917197452229e-2+t3.*t5.*t7.*t157.*1.984968152866242e-2+t5.*t7.*t8.*t158.*7.022292993630573e-3-t5.*t7.*t139.*t140.*1.404458598726115e-2,t9.*t33.*t85-t9.*t10.*t141.*7.022292993630573e-3+t120.*t143.*t156.*2.808917197452229e-2-t125.*t142.*t155.*7.939872611464968e-2+t3.*t7.*t9.*t157.*1.984968152866242e-2+t7.*t8.*t9.*t158.*7.022292993630573e-3-t7.*t9.*t139.*t140.*1.404458598726115e-2];
mt7 = [t7.*t141.*(-7.022292993630573e-3)-t3.*t10.*t33.*(2.0e+2./4.71e+2)-t3.*t10.*t157.*1.984968152866242e-2-t8.*t10.*t158.*7.022292993630573e-3+t10.*t139.*t140.*1.404458598726115e-2+t3.*t7.*t142.*t155.*3.969936305732484e-2+t7.*t8.*t143.*t156.*1.404458598726115e-2,et1+et2];
mt8 = [(t35.*(t10.*u1.*6.0e+1-t10.*u3.*6.0e+1+t59.*u1+t60.*u4+t70.*u3-t18.*t22.*t25.*5.06e+2+phi_dot_t.*psi_dot_t.*t7.*t10.*1.104e+3+t7.*t18.*t22.*t29.*1.012e+3-t3.*t7.*t8.*u2.*5.5e+1-phi_dot_t.*psi_dot_t.*t7.*t10.*t22.*1.012e+3+phi_dot_t.*t3.*t8.*t10.*theta_dot_t.*5.06e+2+psi_dot_t.*t3.*t8.*t24.*theta_dot_t.*5.06e+2-psi_dot_t.*t3.*t8.*t29.*theta_dot_t.*5.06e+2))./5.52e+2-(t10.*t36.*(t71+t81+t112+t117-t7.*u3.*6.0e+1-t26.*u2.*2.2e+1-t26.*u4.*2.2e+1+t34.*u1+t46.*u1+t46.*u3+t61.*u2+phi_dot_t.*psi_dot_t.*t24.*5.52e+2-t3.*t8.*t10.*u4.*5.5e+1+phi_dot_t.*t3.*t7.*t8.*theta_dot_t.*5.06e+2-psi_dot_t.*t3.*t7.*t8.*t10.*theta_dot_t.*5.06e+2))./5.52e+2,et3+et4,0.0,0.0,0.0,0.0,0.0,0.0];
mt9 = [t33.*(t5.*t8-t3.*t9.*t10).*(2.0e+2./4.71e+2)-t120.*t158.*1.404458598726115e-2+t125.*t157.*3.969936305732484e-2-t7.*t9.*t141.*7.022292993630573e-3+t121.*t145.*t155.*7.939872611464968e-2+t124.*t144.*t156.*2.808917197452229e-2+t5.*t7.*t136.*t140.*1.404458598726115e-2];
mt10 = [t33.*(t8.*t9+t3.*t5.*t10).*(2.0e+2./4.71e+2)+t121.*t157.*3.969936305732484e-2-t124.*t158.*1.404458598726115e-2+t5.*t7.*t141.*7.022292993630573e-3-t120.*t144.*t156.*2.808917197452229e-2-t125.*t145.*t155.*7.939872611464968e-2+t7.*t9.*t136.*t140.*1.404458598726115e-2,t10.*t136.*t140.*(-1.404458598726115e-2)+t3.*t7.*t145.*t155.*3.969936305732484e-2-t7.*t8.*t144.*t156.*1.404458598726115e-2,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,-t151-t171-t174,-t152+t172+t173,t149-t162+t163,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,-t153+t170+t175];
mt11 = [-t154-t169-t176,t150-t161+t166,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,t147+t165-t167,t148-t164+t168,-t146-t159-t160,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,(t36.*(t103+t28.*theta_dot_t.*2.3e+1+psi_dot_t.*t3.*t8.*t10.*t24.*5.06e+2))./5.52e+2,t35.*(psi_dot_t.*t24.*5.52e+2-psi_dot_t.*t22.*t24.*5.06e+2+t3.*t7.*t8.*theta_dot_t.*5.06e+2).*(-1.0./5.52e+2),(t36.*(t80+t7.*theta_dot_t.*4.6e+1+psi_dot_t.*t3.*t8.*t24.*5.06e+2))./5.52e+2,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0];
mt12 = [(t36.*(phi_dot_t.*t28.*2.3e+1+psi_dot_t.*t7.*1.058e+3-psi_dot_t.*t7.*t22.*5.06e+2-psi_dot_t.*t22.*t25.*5.06e+2+phi_dot_t.*t7.*t10.*t22.*5.06e+2+t3.*t8.*t24.*theta_dot_t.*1.012e+3))./5.52e+2,t35.*(phi_dot_t.*t3.*t7.*t8.*5.06e+2-psi_dot_t.*t3.*t7.*t8.*t10.*5.06e+2).*(-1.0./5.52e+2),(t36.*(phi_dot_t.*t7.*4.6e+1+psi_dot_t.*t28.*5.29e+2+phi_dot_t.*t7.*t22.*5.06e+2-psi_dot_t.*t7.*t10.*t22.*5.06e+2))./5.52e+2,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,t36.*(t80-t7.*theta_dot_t.*1.058e+3+t22.*t25.*theta_dot_t.*5.06e+2+psi_dot_t.*t3.*t8.*t24.*1.012e+3-phi_dot_t.*t3.*t8.*t10.*t24.*5.06e+2).*(-1.0./5.52e+2)];
mt13 = [t35.*(phi_dot_t.*t24.*5.52e+2-phi_dot_t.*t22.*t24.*5.06e+2+psi_dot_t.*t10.*t22.*t24.*1.012e+3-t3.*t7.*t8.*t10.*theta_dot_t.*5.06e+2).*(-1.0./5.52e+2),(t36.*(t28.*theta_dot_t.*5.29e+2+phi_dot_t.*t3.*t8.*t24.*5.06e+2-t7.*t10.*t22.*theta_dot_t.*5.06e+2-psi_dot_t.*t3.*t8.*t10.*t24.*1.012e+3))./5.52e+2];
A = reshape([mt1,mt2,mt3,mt4,mt5,mt6,mt7,mt8,mt9,mt10,mt11,mt12,mt13],12,12);
if nargout > 1
    mt14 = [0.0,0.0,0.0,0.0,0.0,0.0,t134,t135,t85,t36.*(t38+t69+t79).*(-1.0./5.52e+2),t35.*(t34+t46+t57).*(-1.0./5.52e+2),t36.*(t55+t60+9.2e+1).*(-1.0./5.52e+2),0.0,0.0,0.0,0.0,0.0,0.0,t134,t135,t85,t36.*(t43+t56+t58+t78+1.15e+2).*(-1.0./5.52e+2),(t35.*(t46-t61))./5.52e+2,t36.*(t39+t44+t70-9.2e+1).*(-1.0./5.52e+2),0.0,0.0,0.0,0.0,0.0,0.0,t134,t135,t85,(t36.*(t43+t58+t79))./5.52e+2,(t35.*(t34-t46+t57))./5.52e+2,(t36.*(t44+t60-9.2e+1))./5.52e+2,0.0,0.0,0.0,0.0,0.0,0.0,t134,t135,t85,(t36.*(t38+t56+t69+t78+1.15e+2))./5.52e+2,(t35.*(t46+t61))./5.52e+2];
    mt15 = [(t36.*(t39+t55+t70+9.2e+1))./5.52e+2,0.0,0.0,0.0,0.0,0.0,0.0,t151+t171+t174,t152-t172-t173,-t149+t162-t163,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t153-t170-t175,t154+t169+t176,-t150+t161-t166,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t147-t165+t167,-t148+t164-t168,t146+t159+t160,0.0,0.0,0.0];
    B = reshape([mt14,mt15],12,7);
end
end
